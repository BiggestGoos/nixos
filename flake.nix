{
  
	inputs = 
	{

		nixpkgs = {
			url = "github:BiggestGoos/nixpkgs-globalRules/pam-globalRules"; #"github:NixOS/nixpkgs/nixos-unstable";
		};

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		disko = {
			url = "github:nix-community/disko/latest";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		steam-config-nix = {
			url = "/home/goos/Dev/steam-config-nix"; #"github:BiggestGoos/steam-config-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		szy.url = "/home/goos/Dev/szy-nixos";

		nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";

	};

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

					inputs.disko.nixosModules.disko
					inputs.nixpkgs-xr.nixosModules.nixpkgs-xr

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
												imports = szy.lib.imports.recursive user.data.path;
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
		

		/*nixosConfigurations = (szy.flake.mkConfiguration {
			hostname = "vizima";
			system = "x86_64-linux";
			timeZone = {
				default = "Europe/Stockholm";
				#automatic = true; Work more on this, doesn't work currently (2026-01-24)
			};
			locale = {
				console.keyMap = "sv-latin1";
			};
			rawRoot = "/etc/nixos";
		}) // (szy.flake.mkConfiguration {
			hostname = "kovir";
			system = "x86_64-linux";
			timeZone = {
				default = "Europe/Stockholm";
			};
			locale = {
				console.keyMap = "sv-latin1";
			};
			rawRoot = "/etc/nixos";
		});*/

	};

}
