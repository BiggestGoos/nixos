{ pkgs, lib, config, szy, ... }:
{

	imports = [
		./plasma
		./gnome
		./hyprland
	];

	"${szy}".desktops.configuration = [ {

		"${szy}".desktops = {

			components = {

				displays = {

					displays = {

						main = {

							hardware = {
								description = "Philips Consumer Electronics Company PHL 288E2 AU52038000277";
							};
	
							scale = 1.5;
			
						};

						secondary = {

							hardware = {
								description = "Ancor Communications Inc ASUS VC239 F9LMTJ015363";
							};

							scale = 1.0;

							position = "auto-left";

						};

					};

					default.name = "main";

				};

				devices = {

					keyboards = {

						default = {

							xkb.layout = "se";

						};

					};

				};

			};

			variants.enabled = [
				"autologin"
				"hibernateResume"
			];
				
		};

	} ];

}
