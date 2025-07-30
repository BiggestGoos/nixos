{ pkgs, ... }@args: with args; lib.mkIf (builtins.elem "hyprland" config.desktops.enabled)
{

	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [
			xdg-desktop-portal-hyprland
		];
	};

}
