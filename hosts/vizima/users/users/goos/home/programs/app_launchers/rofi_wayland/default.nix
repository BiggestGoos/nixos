{ pkgs, config, ... }:
let
	configDir = "rofi";
	configHomeDir = "${config.xdg.configHome}/${configDir}";
in
{

	programs.rofi = {

		package = pkgs.rofi-wayland;
		enable = true;

	};

	#home.file."${configHomeDir}/config.rasi" = ./config.rasi;
	home.file."${configHomeDir}/current.rasi" = ./current.rasi;

}
