{ pkgs, ... }@args: with args; lib.mkIf (osConfig.desktops.default == "hyprland")
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
