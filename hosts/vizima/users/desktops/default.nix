{ pkgs, lib, config, szy, ... }:
{

	imports = [
		(import (szy.utils.fromShared "users/desktops") 
		{
			
			"${szy}".desktops = {

				options.displays = {

					displays = {

						main = {

							hardware = {
								portName = "eDP-1";
								description = "Chimei Innolux Corporation 0x1406";
							};

							scale = "1.25";
	
						};

					};

					default.name = "main";

				};

				enabledVariants = [
					"autologin"
					"hibernateResume"
				];
				
			};

		})
		./plasma
		./gnome
		./hyprland
	];

}
