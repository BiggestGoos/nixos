{
  
  inputs = {

  	nixpkgs = {
		url = "github:NixOS/nixpkgs/nixos-unstable";
	};

	home-manager = {
		url = "github:nix-community/home-manager";
		inputs.nixpkgs.follows = "nixpkgs";
	};

	floorp-disable-lto = {
		#url = "github:NixOS/nixpkgs?ref=pull/412138/head"; # 11.27
		url = "github:NixOS/nixpkgs?ref=pull/422814/head"; # 11.28 - Disable lto
		#url = "github:NixOS/nixpkgs?ref=pull/429058/head"; # 11.29
		#url = "github:NixOS/nixpkgs?ref=pull/429123/head"; # 11.29 - NixOS 25.05
	};

  };

  outputs = { self, nixpkgs, home-manager, floorp-disable-lto }@inputs: { 

    nixosConfigurations = 
    let
    	szy = import ./szy { root = ./.; };
	in
    { 

		vizima =
			let
				hostname = "vizima";
			in
			nixpkgs.lib.nixosSystem {
    	
				system = "x86-64-linux";

				specialArgs = { inherit inputs; inherit hostname; inherit szy; };	

    			modules = [ 
	
					({ ... }:
					{

						imports = [

				      		./hosts/${hostname}/configuration.nix
		
							home-manager.nixosModules.home-manager
							{
				
				/*specialisation.test.configuration = {

					home-manager = {
	    				useGlobalPkgs = true;
	    				useUserPackages = true;
	    				users = import ./hosts/${hostname}/users/users/home_manager_users.nix;
						extraSpecialArgs = { inherit inputs; inherit my; inherit hostname; };
  					};

				};*/

	 			home-manager = {
	    			useGlobalPkgs = true;
	    			useUserPackages = true;
					backupFileExtension = "backup";
	    			users = import ./hosts/${hostname}/users/users/home_manager_users.nix;
					extraSpecialArgs = { inherit inputs; inherit hostname; };
  				};
			}

		];

		})

      	];
    };

	kovir = 
	let
		hostname = "kovir";
	in
	nixpkgs.lib.nixosSystem {
		system = "x86-64-linux";

		specialArgs = { inherit inputs; inherit hostname; };

    		modules = [ 	
      			./hosts/${hostname}/configuration.nix 

			home-manager.nixosModules.home-manager
			{
	 			home-manager = {
	    				useGlobalPkgs = true;
	    				useUserPackages = true;
	    				users = import ./hosts/${hostname}/users/users/home_manager_users.nix;
	  			};
			}
      		];

	};
    };
    };
}
