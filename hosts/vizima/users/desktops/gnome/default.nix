{ config, szy, ... }: 
{
	
	services.displayManager.gdm.enable = szy.desktops.isDefault config "gnome";
	services.desktopManager.gnome.enable = true;

}
