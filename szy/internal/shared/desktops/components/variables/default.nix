{ szy, lib, config, ... }:
{

	options."${szy}".desktops.components.variables = {

		default = lib.mkOption {
			type = lib.types.attrsOf lib.types.str;
			default = {};
		};

		variables = lib.mkOption {
			type = lib.types.attrsOf (lib.types.attrsOf lib.types.str);
			default = {};
		};

	};

}
