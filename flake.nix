{
  
	inputs = 
	{

		nixpkgs = {
			url = "github:NixOS/nixpkgs/nixos-unstable";
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
			url = "github:different-name/steam-config-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

	};

	outputs = 
	{ ... }@inputs: 
	let
		szy = import ./szy/library { inherit inputs; };
	in
	{

		nixosConfigurations = (szy.flake.mkConfiguration {
			hostname = "vizima";
			timeZone = {
				default = "Europe/Stockholm";
				automatic = true;
			};
			locale = {
				console.keyMap = "sv-latin1";
			};
			rawRoot = "/etc/nixos";
		}) // (szy.flake.mkConfiguration {
			hostname = "kovir";
			timeZone = {
				default = "Europe/Stockholm";
			};
			locale = {
				console.keyMap = "sv-latin1";
			};
			rawRoot = "/etc/nixos";
		});

	};

}
