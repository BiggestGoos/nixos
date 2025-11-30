{ pkgs, lib, config, ... }:
let
	configDir = "rofi";
	configHomeDir = "${config.xdg.configHome}/${configDir}";
in
{

	programs.rofi = {

		enable = true;

	};

	home.file."${configHomeDir}/config.rasi".source = ./config.rasi;
	home.file."${configHomeDir}/current.rasi".source = ./current.rasi;

}
