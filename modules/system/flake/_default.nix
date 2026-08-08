{ lib, pkgs, szy, ... }:
let
	updateFlakeInputs = pkgs.callPackage ./updateFlakeInputs.nix { inherit szy; };
in
{

	environment.systemPackages =
	[
		updateFlakeInputs
	];

}
