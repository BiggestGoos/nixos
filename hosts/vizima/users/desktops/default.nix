{ pkgs, lib, config, szy, ... }:
{

	imports = [
		(szy.utils.fromShared "users/desktops")
		./plasma
		./gnome
		./hyprland
	];

}
