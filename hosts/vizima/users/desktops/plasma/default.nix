{ config, ... }: #lib.mkIf (config.desktops.default == "plasma") #szy.desktops.ifEnabled "plasma"
{

	services.xserver.enable = true;

	services.displayManager.sddm.enable = (config.desktops.default == "plasma");
	services.displayManager.sddm.wayland.enable = true;
	services.desktopManager.plasma6.enable = true;

}
