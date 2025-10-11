variant:
{ lib, desktop, pkgs, ... }:
lib.mkIf variant.enabled
{

	environment.systemPackages = [
		pkgs.onefetch
	];

}
