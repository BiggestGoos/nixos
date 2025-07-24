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
      		url = "github:NixOS/nixpkgs?ref=pull/422814/head";
    	};

  };

  outputs = { self, nixpkgs, home-manager, floorp-disable-lto }@inputs: { 

    nixosConfigurations = 
    let
    		my.utils.root = builtins.toString ./.;
    		my.utils.fromRoot = path: "${my.utils.root}/${path}";
    in
    { 

	vizima =
	let
		hostname = "vizima";
	in
	nixpkgs.lib.nixosSystem {
    		system = "x86-64-linux";

		specialArgs = { inherit inputs; inherit my; inherit hostname; };

    		modules = [ 	
      			./hosts/${hostname}/configuration.nix 

			home-manager.nixosModules.home-manager
			{
	 			home-manager = {
	    				useGlobalPkgs = true;
	    				useUserPackages = true;
	    				users = import ./hosts/${hostname}/users/users/home_manager_users.nix;
					extraSpecialArgs = { inherit inputs; inherit my; inherit hostname; };
	  			};
			}
      		];
    	};

	kovir = 
	let
		hostname = "kovir";
	in
	nixpkgs.lib.nixosSystem {
		system = "x86-64-linux";

		specialArgs = { inherit inputs; inherit my; inherit hostname; };

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
