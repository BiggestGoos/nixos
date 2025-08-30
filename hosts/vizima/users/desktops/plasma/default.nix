{ config, szy, pkgs, ... }:
{

	services.xserver.enable = true;

	services.displayManager.sddm.enable = szy.desktops.isDefault config "plasma";
	services.displayManager.sddm.wayland.enable = true;
	services.desktopManager.plasma6.enable = true;

}
