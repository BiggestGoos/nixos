{ pkgs, szy, osConfig, lib, desktop, ... }: lib.mkIf (desktop.isDefault "hyprland")
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
