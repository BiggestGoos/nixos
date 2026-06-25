{ lib, pkgs, inputs, osConfig, ... }:
{

	imports = [
		inputs.steam-config-nix.homeModules.default
	];

	config =
	{

		programs.steam.config = {

			enable = true;
			/*steam.autoClose = {
				enable = true;
				#restart.enable = true;
			};*/

			#closeSteam = true;
			shutdownBehavior = "restart";

			defaultCompatTool = "GE-Proton";

			/*default = {
				
				compatTool = "GE-Protonn";
				launchOptions = {

					wrappers = [ "mangohud" "gamemoderun" ];

				};

			};*/

			apps = {

				"20900" = {
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
				};

			};

			users.goos = {

				id = 76561198295332347;

				apps = {

					"427520" = {

						launchOptions = {
							wrappers = [ "mangohud" ];
						};

					};

				};

			};

		};

	};

}
