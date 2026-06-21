{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.obsidian;
in
szy.programs.mkInstance
{

	inherit config;
	program = "notes";
	name = "obsidian";

	values = 
	{ finalCommand, ... }:
	{
		inherit package;
		desktopEntry = "obsidian.desktop";
	};

	configuration =	
	{ enabled, ... }: 
	lib.mkIf (enabled)
	{

		programs.obsidian.enable = true;

	};

}

