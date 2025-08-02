{ pkgs, szy, ... }:# szy.desktops.ifDefault "hyprland"
{

	gtk = {
	    enable = true;
	    theme = {
    		name = "Breeze-Dark";
     		package = pkgs.libsForQt5.breeze-gtk;
    	};
    	
		iconTheme = {
      		name = "Adwaita";
      		package = pkgs.adwaita-icon-theme;
    	};	
    	
		gtk3 = {
      		extraConfig.gtk-application-prefer-dark-theme = true;
    	};

	};
	
  	dconf.settings = {
    	"org/gnome/desktop/interface" = {
      		gtk-theme = "Breeze-Dark";
      		color-scheme = "prefer-dark";
    	};
  	};

}
