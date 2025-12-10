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

	outputs = 
	{ self, nixpkgs, home-manager }@inputs: 
	let
		szy = import ./szy/library { inherit inputs; };
	in
	{

		nixosConfigurations = szy.flake.mkConfiguration {
			hostname = "vizima";
			timeZone = {
				default = "Europe/Stockholm";
				automatic = true;
			};
			locale = {
				console.keyMap = "sv-latin1";
			};
			rawRoot = "/etc/nixos";
		};

	};

}
