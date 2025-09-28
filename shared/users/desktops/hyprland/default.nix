{ config, szy, pkgs, lib, ... }:
szy.desktops.mkDesktop
{

	name = "hyprland";

	configuration = { desktop, args, ... }: 
	{
	
		"${szy}" = {

			desktops = {

				enabledVariants = [
					"wayland"
				];

				options = {

					hibernateResume.commands = [
						"${pkgs.procps}/bin/pkill -USR1 hyprlock"
					];
	
				};
			};
		};

		programs = {

			hyprland = {
				enable = true;
				withUWSM = true;
			};

			uwsm.enable = true;

			hyprlock.enable = true;

		};
	};

	imports = [
		./displayManager.nix
		./polkit.nix
		./xdgPortal.nix
		./variants
	];

	variants = [
		{
			names = [ "tandi" ];
			variants = [ "tandi" ];
		}
	];

}
