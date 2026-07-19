{ lib, inputs, ... }:
{

	inputs = 
	{

		flake-file.url = "github:vic/flake-file";

		home-manager = 
		{
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		szy.url = "/home/goos/Dev/szy-nixos";

	};

	imports =
	let
		allFiles = lib.filesystem.listFilesRecursive ./.;
		flakeFiles =
		builtins.filter
		(
			file:
			let
				fileStr = builtins.toString file;
				isFlakeFile = lib.strings.hasSuffix ".flake" fileStr;
				# We can use different flake inputs based on "profiles". Currently only one at a time is supported but we can easily add support for multiple (One profile per line, easy parsing.)
				profile = builtins.replaceStrings ["\n"] [""] 
				(
					builtins.readFile "./profile"
				);
				isProfileFlakeFile = lib.strings.hasSuffix ".flake.${profile}" fileStr;
				notUnderscorePrefix = !(lib.strings.hasPrefix "${builtins.dirOf fileStr}/_" fileStr);
			in
				(isFlakeFile || isProfileFlakeFile) && notUnderscorePrefix
		) allFiles;
	in
		flakeFiles;

	outputs = 
	{ ... }@inputs:
	let


		inherit (inputs) nixpkgs;
		inherit (nixpkgs) lib;

	in
	{	
		
		nixosConfigurations =
		{

			kovir =
			let
				sharedArgs =
				{
					inherit inputs;
				};

				szy = (inputs.szy.library).addArguments
				{ 
					root = inputs.self.outPath;
					flake.root = "/etc/nixos";
					host =
					{
						name = "kovir";
						system = "x86_64-linux";
						path = ./hosts/kovir;
					};
				};

				szyModules = inputs.szy.modules;
			in
			lib.nixosSystem
			{

				inherit (szy.data.host) system;

				specialArgs =
				sharedArgs //
				{
					szy = szy.addArguments 
					{
						configType = "system";
					};
				};

				modules =
				(szyModules.system) ++
				(szy.lib.imports.recursive szy.data.root.modules.system) ++
				(szy.lib.imports.recursive szy.data.host.path) ++
				[
					

					inputs.home-manager.nixosModules.home-manager
					(
						{ config, ... }:
						{
							home-manager = 
							{
		    					useUserPackages = true;
								backupFileExtension = "backup";

		    					users = 
								let
									homeManagedUserMeta = (szy config).objects.utils.template.getMeta { identifier = "homeManagedUser"; };
									users' = 
									builtins.map
									(
										identifier:
										let
											user = (szy config).objects.utils.definition.get { inherit identifier; };
										in
										{
											name = user.data.username;
											value =
											{
												imports = 
												builtins.concatLists
												(
													builtins.map
													(
														path:
															szy.lib.imports.recursive path
													) user.data.paths
												);
											};
										}
									) homeManagedUserMeta.full.definitions;

									users = builtins.listToAttrs users';
								in
									users;

								extraSpecialArgs = 
								sharedArgs // 
								{ 
									szy = szy.addArguments
									{
										configType = "user";
									};
								};
								sharedModules = 
								(szyModules.user) ++
								(szy.lib.imports.recursive szy.data.root.modules.user);
							};
						}
					)

				];

			};

		};

	};

}
