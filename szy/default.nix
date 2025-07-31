{ inputs, hostname }:
let
	flake = inputs.self;
	root = "${flake}";

	inherit (inputs.nixpkgs) lib;
	inherit (flake.nixosConfigurations.${hostname}) config;
in
{

	utils = import ./utils.nix { inherit root; };
	desktops = import ./desktops.nix { inherit config lib; };

}
