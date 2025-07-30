{ config, ... }@args:
let
	configHomeDir = "${config.xdg.configHome}/hypr";
	configHyprlandDir = "hyprland";
	configFullDir = "${configHomeDir}/${configHyprlandDir}";
in
with args; lib.mkIf (builtins.elem "hyprland" osConfig.desktops.enabled)
{

	wayland.windowManager.hyprland = {

		enable = true;

		settings =
		{

			source = 
			let
				config_dir = "./${configHyprlandDir}";
			in
			[
				"${config_dir}/hyprland.conf"
			];

		};

	};

	home.file.${configFullDir}.source = ./${configHyprlandDir};

}
