{ config, ... }: # lib.mkIf (config.desktops.default == "gnome") #szy.desktops.ifEnabled "gnome"
{

	services.displayManager.gdm.enable = (config.desktops.default == "gnome");#szy.desktops.isDefault "gnome";
	services.desktopManager.gnome.enable = true;

}
