{ ... }@args: with args; lib.mkIf (builtins.elem "plasma" config.desktops.enabled)
{

	services.xserver.enable = true;

	services.displayManager.sddm.enable = with args; (config.desktops.default == "plasma");
	services.displayManager.sddm.wayland.enable = true;
	services.desktopManager.plasma6.enable = true;

}
