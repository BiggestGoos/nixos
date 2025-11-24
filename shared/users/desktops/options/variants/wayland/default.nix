variant:
{ lib, config, szy, ... }:
let

	variables = {

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

	enabledFor = config."${szy}".desktops.options.wayland.variables.enabledFor;

in
{

	options."${szy}".desktops.options.wayland.variables.enabledFor = lib.mkOption { 
		type = lib.types.listOf (lib.types.enum config."${szy}".desktops.available);
		default = [];
	};

	config."${szy}".desktops = { 

		options.variables.variables = lib.mkIf variant.enabled (builtins.listToAttrs (builtins.map 
		(desktop: 
		{
			name = desktop;
			value = variables;
		}
		) enabledFor));

		variants.enabled = lib.mkIf (enabledFor != []) [ "wayland" ];

	};

}
