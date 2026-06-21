{ config, szy, pkgs, ... }:
let
	configHomeDir = "${config.xdg.configHome}/hypr";
	configHyprlandDir = "hyprland";
	configFullDir = "${configHomeDir}/${configHyprlandDir}";
in
{

	# When I change this to finally using nix more I will just make the backlight buttons reference with '${pkgs.brightnessctl}/bin/...".
	home.packages = [
		pkgs.brightnessctl
	];

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
