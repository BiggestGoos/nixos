{ pkgs, lib, config, szy, ... }:
{

	imports = [
		(szy.utils.fromShared "users/desktops")
		./plasma
		./gnome
		./hyprland
	];

	"${szy}".desktops.enabledVariants = [
		"autologin"
		"hibernateResume"
	];

}
