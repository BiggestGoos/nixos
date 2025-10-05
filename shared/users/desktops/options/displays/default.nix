{ szy, lib, config, ... }:
{

	options."${szy}".desktops.options.displays = {

		displays = lib.mkOption {
			type = 
			let
				template.options = {
				
					hardware = {

						portName = lib.mkOption {
							type = lib.types.str;
						};

						description = lib.mkOption {
							type = lib.types.nullOr lib.types.str;
							default = null;
						};

					};

					resolution = {

						width = lib.mkOption {
							type = lib.types.ints.positive;
							default = 1920;
						};

						height = lib.mkOption {
							type = lib.types.ints.positive;
							default = 1080;
						};

					};

					refreshRate = lib.mkOption {
						type = lib.types.strMatching "[1-9][0-9]*[.][0-9]+";
						default = "60.0";
					};

					position = {

						x = lib.mkOption {
							type = lib.types.int;
							default = 0;
						};

						y = lib.mkOption {
							type = lib.types.int;
							default = 0;
						};

					};

					scale = lib.mkOption {
						type = lib.types.strMatching "[1-9][0-9]*[.][0-9]+";
						default = "1.0";
					};

					modeline = lib.mkOption {
						type = lib.types.nullOr lib.types.str;
						default = null;
					};

				};
			in
				lib.types.attrsOf (lib.types.submoduleWith { modules = [ template ]; });
		};

		default = {

			name = 
			let
				displayNames = (builtins.attrNames (config."${szy}".desktops.options.displays.displays));
			in
			lib.mkOption {
				type = lib.types.enum displayNames;
				default = builtins.head displayNames;
			};

			values = lib.mkOption {
				type = lib.types.attrs;
				readOnly = true;
				default = config."${szy}".desktops.options.displays.displays."${config."${szy}".desktops.options.displays.default.name}";
			};

		};

	};

}
