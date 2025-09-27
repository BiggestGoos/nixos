{ inputs, hostname }:
let
	flake = inputs.self;
	root = "${flake}";

	inherit (inputs.nixpkgs) lib;
	inherit (flake.nixosConfigurations.${hostname}) config;
in
rec {

	inherit config;
	utils = import ./utils.nix { inherit root hostname lib; };
	desktops = import ./desktops/desktops.nix { inherit config lib options utils; };
	profiles = import ./profiles/profiles.nix { inherit config lib; };
	variants = import ./variants { inherit options lib utils; };

	options = "szy-" + utils.hostname;
	__toString = self: self.options;

}
