{ pkgs, szy, ... }: szy.desktops.ifDefault "hyprland"
{

	qt = {
    	enable = true;
    	platformTheme.name = "gtk";
    	style = {
    		name = "gtk2";
    		package = pkgs.libsForQt5.breeze-qt5;
    	};
  	};

}
