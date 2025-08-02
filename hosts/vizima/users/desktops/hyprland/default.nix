{ ... }:
{
	
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
