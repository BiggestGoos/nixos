{ lib, config, ... }:
{

	options.desktops = {

		available = lib.mkOption {
			type = lib.types.listOf lib.types.str;
			readOnly = true;
			default = [ "hyprland" "gnome" "plasma" ];
		};

		default = lib.mkOption {
			type = lib.types.nullOr (lib.types.enum config.desktops.available);
			default = null;
		};

		enabled = lib.mkOption {
			type = lib.types.nullOr (lib.types.listOf (lib.types.enum config.desktops.available));
			default = null;
		};

	};

}
