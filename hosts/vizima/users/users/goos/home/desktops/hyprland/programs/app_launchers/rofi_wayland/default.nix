{ pkgs, config, ... }@args:
let
	configDir = "rofi";
	configHomeDir = "${config.xdg.configHome}/${configDir}";
in
with args; lib.mkIf (builtins.elem "hyprland" osConfig.desktops.enabled)
{

	programs.rofi = {

		package = pkgs.rofi-wayland;
		enable = true;

	};

	home.file."${configHomeDir}/config.rasi".source = ./config.rasi;
	home.file."${configHomeDir}/current.rasi".source = ./current.rasi;

}
