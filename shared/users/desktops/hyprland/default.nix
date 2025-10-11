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

			};
		};

		programs = {

			hyprland = {
				enable = true;
				withUWSM = true;
			};

			uwsm.enable = true;

		};
	};
	
	imports = [
		./displayManager.nix
		./lockscreens.nix
		./polkit.nix
		./xdgPortal.nix
		./variants
	];

	variants = [
		{
			names = [ "fallout" ];
			variants = [ "fallout" ];
		}
	];

}
