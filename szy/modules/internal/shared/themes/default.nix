{ szy, lib, config, ... }@args:
let
	isHomeManaged = args ? "osConfig";
in
{

	options."${szy}".themes = {
	
		# E.g. "Fallout", or "The Witcher", or "Star Wars".
		enabled = lib.mkOption {
			type = lib.types.nullOr lib.types.str;
			readOnly = isHomeManaged;
			default = if !isHomeManaged then null else args.osConfig."${szy}".themes.enabled;
		};

		# E.g. "Dark", and "Light".
		modifiers = lib.mkOption {
			type = lib.types.nullOr (lib.types.listOf lib.types.str);
			readOnly = isHomeManaged;
			default = if !isHomeManaged then null else args.osConfig."${szy}".themes.modifiers;
		};

		# Add some sort of option where you can map colors or other styling values to a theme as well as inside that theme map things to specific modifiers, maybe

	};

}
