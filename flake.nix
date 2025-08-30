{
  
  inputs = {

  	nixpkgs = {
		url = "github:NixOS/nixpkgs/nixos-unstable";
	};

	home-manager = {
		url = "github:nix-community/home-manager";
		inputs.nixpkgs.follows = "nixpkgs";
	};

  };

  outputs = { self, nixpkgs, home-manager, }@inputs: { 

    nixosConfigurations = 
    let
    	
		
	in
    { 

		vizima =
			let
				hostname = "vizima";
				szy = import ./szy { inherit inputs; inherit hostname; };
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
					extraSpecialArgs = { inherit inputs; inherit hostname; inherit szy; };
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
