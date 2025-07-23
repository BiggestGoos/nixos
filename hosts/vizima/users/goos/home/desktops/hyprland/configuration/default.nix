{ config, ... }:
let
	configHomeDir = "${config.xdg.configHome}/hypr";
	configHyprlandDir = "hyprland";
	configFullDir = "${configHomeDir}/${configHyprlandDir}";
in
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

	home.file.${configFullDir}.source = config.lib.file.mkOutOfStoreSymlink ./${configHyprlandDir};

}
