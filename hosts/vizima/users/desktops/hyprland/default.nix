{ pkgs, ... }:
{

	imports = [
		./hyprland.nix
		./polkit.nix
		./uwsm.nix
		./xdg_portal.nix
	];

}
