{ szy, config, pkgs, ... }:
{
	
	security.pam.services.hyprlock = {};

	"${szy}".desktops.options.hibernateResume.commands = [
		"${pkgs.procps}/bin/pkill -USR1 hyprlock"
	];

}
