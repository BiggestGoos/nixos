{ ... }@args: with args; lib.mkIf (builtins.elem "gnome" config.desktops.enabled)
{

	services.displayManager.gdm.enable = with args; (config.desktops.default == "gnome");
	services.desktopManager.gnome.enable = true;

}
