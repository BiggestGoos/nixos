{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.discord;
in
szy.programs.mkInstance
{

	inherit config;
	program = "discord";

	values = 
	{ finalCommand, ... }:
	rec {
		inherit package;
		desktopEntry = "discord.desktop";
		autostart = "${finalCommand} ${silentArgument}";
		silentArgument = "--start-minimized";
	};

	configuration = 
	{ enabled, ... }:
	lib.mkIf (enabled)
	{

		programs.discord.enable = true;

	};

}
