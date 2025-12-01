{ inputs, hostname, rawRoot }:
let
	flake = inputs.self;
	root = "${flake}";

	inherit (inputs.nixpkgs) lib;
	inherit (flake.nixosConfigurations.${hostname}) config;
in
rec {

	inherit config;
	utils = import ./utils { inherit root rawRoot hostname lib; };
	desktops = import ./desktops { inherit config lib options utils; };
	profiles = import ./profiles;
	programs = import ./programs { inherit config lib options utils; };
	variants = import ./variants { inherit options lib utils; };
	themes = import ./themes { inherit options lib utils variants; };

	options = "szy-" + utils.hostname;
	__toString = self: self.options;

}
