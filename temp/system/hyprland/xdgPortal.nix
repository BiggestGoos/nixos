{ config, ... }:
{

	xdg.portal = {

		enable = true;

		extraPortals = [
			config.programs.hyprland.portalPackage
		];

		xdgOpenUsePortal = true;

	};

}
