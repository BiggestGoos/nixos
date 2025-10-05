variant:
{ lib, config, szy, ... }:
lib.mkIf variant.enabled
{

	"${szy}".desktops.options.variables.default = {

		NIXOS_OZONE_WL = "1";

		# Toolkits use wayland
		GDK_BACKEND = "wayland,x11,*";
		QT_QPA_PLATFORM = "wayland;xcb";
		SDL_VIDEODRIVER = "wayland";
		CLUTTER_BACKEND = "wayland";

		# Qt
		QT_AUTO_SCREEN_SCALE_FACTOR = "1";

		# Electron
		ELECTRON_OZONE_PLATFORM_HINT = "auto";

	};

}
