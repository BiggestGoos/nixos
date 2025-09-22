{ config, szy, ... }:
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

			"$browser" = config."${szy}".browsers.defaultValues.command;

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
