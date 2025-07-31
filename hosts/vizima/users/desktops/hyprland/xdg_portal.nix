{ pkgs, szy, ... }:# szy.desktops.ifEnabled "hyprland"
{

	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [
			xdg-desktop-portal-hyprland
		];
	};

}
