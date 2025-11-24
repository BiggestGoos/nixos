{ szy, pkgs, ... }:
{

	imports = [  
		(import (szy.utils.fromRoot "shared/system/management.nix") { path = "/etc/nixos"; })
		(szy.utils.fromRoot "szy/profiles")
		(szy.utils.fromRoot "szy/themes")
		./users
		./system
		./misc
	];

	services.printing.enable = true;
services.printing.drivers = [ pkgs.hplip ];

	environment.systemPackages = [
		pkgs.system-config-printer
#		pkgs.playerctl
	];

	services.avahi = {
  enable = true;
  nssmdns4 = true;
  openFirewall = true;
};

	system.stateVersion = "25.05"; 

}

