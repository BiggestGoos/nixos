{ config, szy, pkgs, lib, ... }:
szy.desktops.mkDesktop
{

	name = "plasma";

	enabled = [ "gnome" ];

	configuration = { desktop, ... }: {
	
		services.desktopManager.plasma6.enable = true; 
	
	};
	
	imports = [
		./config.nix
	];

}
