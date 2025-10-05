{ pkgs, szy, osConfig, lib, desktop, ... }: lib.mkIf (desktop.isDefaultStrict [ "hyprland" ])
{

	qt = {
    	enable = true;
    	platformTheme.name = "gtk";
    	style = {
    		name = "gtk2";
    		package = pkgs.kdePackages.breeze-gtk;
    	};
  	};

}
