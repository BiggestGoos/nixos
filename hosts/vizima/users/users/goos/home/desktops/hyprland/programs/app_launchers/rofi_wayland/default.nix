{ pkgs, lib, config, osConfig, szy, ... }@args:
let
	configDir = "rofi";
	configHomeDir = "${config.xdg.configHome}/${configDir}";
in
#szy.desktops.ifDefault "hyprland"
lib.mkIf (osConfig.desktops.default == "hyprland")
{

	programs.rofi = {

		package = pkgs.rofi-wayland;
		enable = true;

	};

	home.file."${configHomeDir}/config.rasi".source = ./config.rasi;
	home.file."${configHomeDir}/current.rasi".source = ./current.rasi;

}
