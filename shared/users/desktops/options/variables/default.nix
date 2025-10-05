{ szy, lib, config, ... }:
{

	options."${szy}".desktops.options.variables = {

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
