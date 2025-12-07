{ szy, lib, config, ... }@args:
let
	isHomeManaged = args ? "osConfig";
in
{

	options."${szy}".themes = {

		enabled = lib.mkOption {
			type = lib.types.nullOr lib.types.str;
			default = if !isHomeManaged then null else args.osConfig."${szy}".themes.enabled;
		};

		modifiers = lib.mkOption {
			type = lib.types.nullOr (lib.types.listOf lib.types.str);
			default = if !isHomeManaged then null else args.osConfig."${szy}".themes.modifiers;
		};

	};

}
