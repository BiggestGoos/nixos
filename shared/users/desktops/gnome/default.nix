{ config, szy, pkgs, lib, ... }:
szy.desktops.mkDesktop
{

	name = "gnome";

	#enabled = [ "plasma" ];

	configuration = { desktop, args, ... }: {
	
		services.desktopManager.gnome.enable = true;
		#programs.ssh.askPassword = lib.mkIf (args.config."${szy}".desktops.desktopData.isDefault "gnome") (lib.mkForce "${pkgs.seahorse.out}/libexec/seahorse/ssh-askpass");
		programs.ssh.askPassword = lib.mkIf (desktop.isEnabled "plasma") (lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass");

	};

	imports = [
		./config.nix
	];

}
