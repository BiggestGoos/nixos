{ szy, config, pkgs, desktop, lib, ... }:
lib.mkIf (desktop.isEnabledStrict [ "hyprland" ])
{
	
	security.pam.services.hyprlock = {};

	"${szy}".desktops.components.hibernateResume.commands = [
		"${pkgs.procps}/bin/pkill -USR1 hyprlock"
	];

}
