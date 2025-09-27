{ desktop, ... }:
{

	services.displayManager.gdm.enable = desktop.isDefault "gnome";

}
