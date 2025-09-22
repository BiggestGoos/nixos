{ inputs, hostname }:
let
	flake = inputs.self;
	root = "${flake}";

	inherit (inputs.nixpkgs) lib;
	inherit (flake.nixosConfigurations.${hostname}) config;
in
rec {

	utils = import ./utils.nix { inherit root hostname; };
	desktops = import ./desktops/desktops.nix { inherit lib; };
	profiles = import ./profiles/profiles.nix { inherit config lib; };
	variants = import ./variants { inherit options lib; };

	options = "szy-" + utils.hostname;
	__toString = self: self.options;

}
