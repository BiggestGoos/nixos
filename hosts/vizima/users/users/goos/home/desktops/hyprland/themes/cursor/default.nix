{ pkgs, ... }@args: with args; lib.mkIf (osConfig.desktops.default == "hyprland")
{

	home.pointerCursor = {
    	gtk.enable = true;
    	hyprcursor.enable = true;
		x11.enable = true;
		x11.defaultCursor = "Vanilla-DMZ";

		name = "Vanilla-DMZ";
    	package = pkgs.vanilla-dmz;
    	#size = 16;
  	};

}
