{ pkgs, ... }:
{

	imports = [
		./autologin.nix

		./hyprland/configuration.nix
	];

}
