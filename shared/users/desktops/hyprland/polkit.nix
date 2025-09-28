{ desktop, lib, pkgs, ... }:
{

	environment.systemPackages = [
		pkgs.hyprpolkitagent
	];

	system.userActivationScripts.enableHyprpolkitagent = "${pkgs.systemd}/bin/systemctl --user enable hyprpolkitagent";

}
