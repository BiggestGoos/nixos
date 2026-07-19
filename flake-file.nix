{ lib, inputs, ... }:
{

	inputs = 
	{

		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		flake-file.url = "github:vic/flake-file";

		home-manager = 
		{
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		szy.url = "github:BiggestGoos/szy-nixos";

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
				notUnderscorePrefix = !(lib.strings.hasPrefix "${builtins.dirOf fileStr}/_" fileStr);
			in
				isFlakeFile && notUnderscorePrefix
		) allFiles;
	in
		flakeFiles;

	outputs = 
	{ ... }@inputs:
	let


		inherit (inputs) nixpkgs;
		inherit (nixpkgs) lib;
		
		configurations = 
		{ 
			root, 
			system, 
			modules ? [],
		}:
		let

			mkHost = name: path:
			let
				sharedArgs =
				{
					inherit inputs;
				};

				szy = (inputs.szy.library).addArguments
				{ 
					root = inputs.self.outPath;
					flake =
					{
						inherit root;
					};
					host =
					{
						inherit
							system
							name
							path
						;
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
				(modules) ++
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
								useGlobalPkgs = true;

								backupFileExtension = "backup";
								overwriteBackup = true;

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

			hostFolder = ./hosts;

			# An attrs of the names of all host-folders in `hostFolder`.
			hosts =
			let
				allFiles = builtins.readDir hostFolder;
			in
			lib.attrsets.filterAttrs
			(
				name: value:
					value == "directory"
			) allFiles;

		in
		lib.attrsets.mapAttrs
		(
			name: _: mkHost name (hostFolder + "/${name}")
		) hosts;

	in
	{

		call = inputs:
		{
			nixosConfigurations = configurations inputs;
		};

	};

}
