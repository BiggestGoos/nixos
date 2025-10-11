{ pkgs, szy, osConfig, lib, desktop, ... }: lib.mkIf (desktop.isDefault [ "hyprland" ])
{

	gtk = {
	    enable = true;
	    theme = {
    		name = "Breeze-Dark";
     		package = pkgs.kdePackages.breeze-gtk;
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
