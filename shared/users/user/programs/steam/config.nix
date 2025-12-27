enabled:
{ lib, config, osConfig, pkgs, szy, inputs, ... }:
{

	imports = [
		inputs.steam-config-nix.homeModules.default
	];

	config = enabled
	{

		programs.steam.config = {

			enable = true;
			closeSteam = true;

			defaultCompatTool = "GE-Proton";

			apps = {

	/*			"20900" = {
					launchOptions = {
	
						env = {
							LD_PRELOAD = "";
						};

						wrappers = [
							"${lib.meta.getExe pkgs.gamescope}"
							"-w" "1920" "-h" "1080" "--fullscreen" "--force-grab-cursor" "--rt" "--expose-wayland" "--" 
							"${lib.meta.getExe' pkgs.mangohud "mangohud"}"
							"${lib.meta.getExe' pkgs.gamemode "gamemoderun"}"
						];

					};
				};*/

			};

		};

	};

}
