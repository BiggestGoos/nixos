{ desktop, szy, config, ... }:
{

	services.xserver.enable = true;

	services.displayManager.sddm.enable = desktop.isDefault [ "plasma" ];
	services.displayManager.sddm.wayland.enable = true;

}
