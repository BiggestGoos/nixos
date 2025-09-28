{ config, szy, pkgs, lib, ... }:
szy.desktops.mkDesktop
{

	name = "hyprland";

	#enabled = [ "plasma" ];

	configuration = { desktop, args, ... }: {
	
		
			
	};

	imports = [
		./hyprland.nix
		./polkit.nix
		./uwsm.nix
		./xdg_portal.nix
		./programs
		./luks_resume.nix
		./autologin.nix
	];

}
