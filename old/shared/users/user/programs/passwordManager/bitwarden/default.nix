{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.bitwarden-desktop;
in
szy.programs.mkInstance
{

	inherit config;
	program = "passwordManager";
	name = "bitwarden";

	values = 
	{
		inherit package;
		desktopEntry = "bitwarden.desktop";
	};

	configuration = 
	{ enabled, optionKeys, ... }:
	lib.mkIf (enabled)
	{

		home.packages = [ package ];

	};

}
