{ szy, lib, config, ... }:
{

	options."${szy}".desktops.options.displays = 
	let
		displayNames = (builtins.attrNames (config."${szy}".desktops.options.displays.displays));
	in
	{

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

					displayMode = lib.mkOption {

						type = lib.types.either (lib.types.enum [
								"preferred" # use the display’s preferred size and refresh rate
								"highResolution" # use the highest supported resolution
								"highRefreshRate" # use the highest supported refresh rate
								"maxWidth" # use the widest supported resolution
						]) (lib.types.submoduleWith { modules = [ { options = {

							resolution = {

								width = lib.mkOption {
									type = lib.types.ints.positive;
								};

								height = lib.mkOption {
									type = lib.types.ints.positive;
								};

							};

							refreshRate = lib.mkOption {
								type = lib.types.addCheck lib.types.number (x: x >= 0);
							};

						}; } ]; });

						default = "preferred";

					};

					transform = lib.mkOption {
						type = lib.types.addCheck lib.types.ints.unsigned (x: x <= 7);
						default = 0;
						description = ''0 -> normal (no transforms)
										1 -> 90 degrees
										2 -> 180 degrees
										3 -> 270 degrees
										4 -> flipped
										5 -> flipped + 90 degrees
										6 -> flipped + 180 degrees
										7 -> flipped + 270 degrees'';
					};

					position = lib.mkOption {

						type = 
						let
							directions = [ "right" "left" "up" "down" ];
						in
						lib.types.either (lib.types.enum (
						[ "auto" ] ++ 
						(builtins.map (direction: "auto-${direction}") directions) ++
						(builtins.map (direction: "auto-center-${direction}") directions))) (lib.types.submoduleWith { modules = [ { options = {

							x = lib.mkOption {
								type = lib.types.int;
							};

							y = lib.mkOption {
								type = lib.types.int;
							};

						}; } ]; });

						default = "auto";

					};

					scale = lib.mkOption {
						type = lib.types.either (lib.types.addCheck lib.types.number (x: x >= 0.0)) (lib.types.enum [ "auto" ]);
						default = "auto";
					};

					mirror = lib.mkOption {
						type = lib.types.nullOr (lib.types.enum displayNames);
						default = null;
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

			name = lib.mkOption {
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
