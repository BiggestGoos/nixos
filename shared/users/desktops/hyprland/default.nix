{ config, szy, pkgs, lib, ... }:
szy.desktops.mkDesktop
{

	name = "hyprland";

	configuration = { desktop, args, ... }: 
	{
	
		"${szy}" = {
		
			desktops.components.wayland.variables.enabledFor = [
				"hyprland"
			];

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
		./lockscreen.nix
		./xdgPortal.nix
		./variants
		./brightness.nix
	];

	globalImports = [
		./brightnessGlobal.nix
	];

	styles = [
		{
			names = [ "fallout" ];
			variants = [ "fallout" ];
		}
	];

}
