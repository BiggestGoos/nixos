{ config, szy, pkgs, lib, ... }:
szy.desktops.mkDesktop
{

	name = "plasma";

	enabled = [ "gnome" ];

	configuration = { desktop, ... }: {
	
		services.desktopManager.plasma6.enable = true; 
		programs.ssh.askPassword = lib.mkIf (desktop.isDefault "plasma") (lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass");

	};

	imports = [
		./config.nix
	];

}
