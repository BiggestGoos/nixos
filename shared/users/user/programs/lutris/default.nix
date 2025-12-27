{ szy, lib, config, osConfig, pkgs, ... }:
let
	package = pkgs.lutris;
in
szy.programs.mkInstance
{

	inherit config;
	program = "lutris";

	values = 
	{ finalCommand, ... }:
	rec {
		inherit package;
		desktopEntry = "lutris.desktop";
	};

	configuration = 
	{ enabled, ... }:
	lib.mkIf (enabled)
	{

		programs.lutris = {

			enable = true;

			steamPackage = osConfig.programs.steam.package;

			protonPackages = [
				pkgs.proton-ge-bin
			];
			defaultWinePackage = pkgs.proton-ge-bin;

			extraPackages = with pkgs; [
				libadwaita
				gtk4
			];

		};

	};

}
