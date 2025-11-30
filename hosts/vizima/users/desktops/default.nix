{ pkgs, lib, config, szy, ... }:
{

	imports = [
		./plasma
		./gnome
		./hyprland
	];

	"${szy}".desktops.configuration = {

		"${szy}".desktops = {

			components = {

				displays = {

					displays = {

						main = {

							hardware = {
								portName = "eDP-1";
								description = "Chimei Innolux Corporation 0x1406";
							};
	
							scale = 1.25;
			
						};

						secondary = {

							hardware = {
								portName = "HDMI-A-1";
								description = "Philips Consumer Electronics Company PHL 288E2 AU52038000277";
							};

							scale = 1.5;

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
	
					pointers = {

						touchpads.default = {
								
							scrolling = {

								factor = 0.5;

							};

							tapAndDrag = "timeout";

							clickfingerBehavior = true;

						};

						touchpads.touchpads.laptop = {

							hardware.name = "syna30bd:00-06cb:ce08-2";

							sensitivity = 0;

						};

						generics.generics.pointingStick = {

							hardware.name = "syna30bd:00-06cb:ce08-1";

							sensitivity = -1;

						};

					};

				};

			};

			variants.enabled = [
				"autologin"
				"hibernateResume"
			];
				
		};

	};

}
