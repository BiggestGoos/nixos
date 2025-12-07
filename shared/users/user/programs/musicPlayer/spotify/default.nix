{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.spotify;
in
szy.programs.mkInstance
{

	inherit config;
	program = "musicPlayer";
	name = "spotify";

	values = 
	{ finalCommand, ... }:
	{
		inherit package;
		desktopEntry = "spotify.desktop";
	};

	configuration =	
	{ enabled, ... }: 
	lib.mkIf (enabled)
	{

		home.packages = [
			package
		];

	};

}

