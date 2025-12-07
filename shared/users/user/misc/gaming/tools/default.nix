enabled:
{ lib, pkgs, ... }:
lib.mkIf (enabled)
{

	home.packages = [
		pkgs.protonup-qt
	];

}
