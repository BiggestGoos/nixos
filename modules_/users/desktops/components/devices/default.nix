{ szy, lib, config, ... }:
{

	options."${szy}".desktops.components.devices = {

		keyboards = 
		let

			template.options = {

				xkb = (builtins.listToAttrs (builtins.map 
					(option: 
					{ 
						name = option; 
						value = lib.mkOption {
							type = lib.types.nullOr lib.types.str;
							default = null;
						};
					}) [ 
						"model"
						"layout"
						"variant"
						"options"
						"rules" 
					])
				);

				repeat = {

					rate = lib.mkOption {
						type = lib.types.nullOr lib.types.ints.positive;
						default = null;
						description = "Key repeats per second";
					};

					delay = lib.mkOption {
						type = lib.types.nullOr lib.types.ints.positive;
						default = null;
						description = "Delay in milliseconds before a key is repeated";
					};

				};

			};

		in
		{

			default = lib.mkOption {
				type = lib.types.submoduleWith { modules = [ template ]; };
				default = {};
			};

			keyboards = lib.mkOption {
				type = 
				let
					extraTemplate.options = {

						hardware.name = lib.mkOption {
							type = lib.types.str;
						};

					};
				in
					lib.types.attrsOf (lib.types.submoduleWith { modules = [ template extraTemplate ]; });
				default = {};
			};

		};

		pointers = 
		let

			accelerationGenerator = values: lib.mkOption {
				type = 
				let
					template.options = 
					let
						template.options = {
								
							step = lib.mkOption {
								type = lib.types.addCheck lib.types.number (x: x > 0);
							};

							points = lib.mkOption {
								type = lib.types.listOf (lib.types.addCheck lib.types.number (x: x >= 0));
							};

						};
					in
					{

						movement = lib.mkOption {
							type = lib.types.submoduleWith { modules = [ template ]; };
						};

						scrolling = lib.mkOption {
							type = lib.types.nullOr (lib.types.submoduleWith { modules = [ template ]; });
							default = null;
						};

					};
				in
					lib.types.nullOr (lib.types.either (lib.types.enum values) (lib.types.submoduleWith { modules = [ template ]; }));
				default = null;
			};
		
			genericTemplate.options = {

				sensitivity = lib.mkOption {
					type = lib.types.nullOr (lib.types.addCheck lib.types.number (x: x >= -1.0 && x <= 1.0));
					default = null;
				};

			};

			scrolling.options = {

				scrolling = {

					factor = lib.mkOption {
						type = lib.types.nullOr lib.types.number;
						default = null;
					};

					natural = lib.mkOption {
						type = lib.types.nullOr lib.types.bool;
						default = null;
					};

				};

			};

		in
		{

			mice = 
			let

				innerTemplate.options = {

					rotation = lib.mkOption {
						type = lib.types.nullOr (lib.types.addCheck lib.types.ints.unsigned (x: x <= 359));
						default = null;
					};

				};

			in
			{

				default = lib.mkOption {
					type = 
					let
						extraTemplate.options = {

						};
					in
						lib.types.submoduleWith { modules = [ innerTemplate extraTemplate ]; };
					default = {};
				};

				mice = lib.mkOption {
					type = 
					let
						extraTemplate.options = {

							hardware.name = lib.mkOption {
								type = lib.types.str;
							};

							acceleration = accelerationGenerator [ "adaptive" "flat" ];

							scrolling.method = lib.mkOption {
								type = 
								let
									template.options.scrollButton = {
								
										id = lib.mkOption {
											type = lib.types.ints.unsigned;
											default = 0; # 0 means default
										};

										lock = lib.mkOption {
											type = lib.types.bool;
											default = false;
										};

									};
								in
									lib.types.nullOr (lib.types.either (lib.types.enum [ "none" ]) (lib.types.submoduleWith { modules = [ template ]; }));
								default = null;
								description = "If a set then scroll-button method will be used";
							};

						};
					in
						lib.types.attrsOf (lib.types.submoduleWith { modules = [ scrolling genericTemplate innerTemplate extraTemplate ]; });
					default = {};
				};

			};

			touchpads = 
			let

				innerTemplate.options = {

					disableWhileTyping = lib.mkOption {
						type = lib.types.nullOr lib.types.bool;
						default = null;
					};

					middleButtonEmulation = lib.mkOption {
						type = lib.types.nullOr lib.types.bool;
						default = null;
					};

					clickfingerBehavior = lib.mkOption {
						type = lib.types.nullOr lib.types.bool;
						default = null;
					};

					tapToClick = lib.mkOption {
						type = lib.types.nullOr lib.types.bool;
						default = null;
					};

					tapAndDrag = lib.mkOption {
						type = lib.types.nullOr (lib.types.either (lib.types.bool) (lib.types.enum [ "noLock" "timeout" "sticky" ]));
						default = null;
					};

					flipMovement = {
		
						x = lib.mkOption {
							type = lib.types.nullOr lib.types.bool;
							default = null;
						};

						y = lib.mkOption {
							type = lib.types.nullOr lib.types.bool;
							default = null;
						};

					};
	
				};

			in
			{

				default = lib.mkOption {
					type = 
					let
						extraTemplate.options = {

						};
					in
						lib.types.submoduleWith { modules = [ scrolling innerTemplate extraTemplate ]; };
					default = {};
				};

				touchpads = lib.mkOption {
					type = 
					let
						extraTemplate.options = {

							hardware.name = lib.mkOption {
								type = lib.types.str;
							};

							acceleration = accelerationGenerator [ "adaptive" "flat" ];

							scrolling.method = lib.mkOption {
								type = lib.types.nullOr (lib.types.enum [ "twoFingers" "edge" "none" ]);
								default = null;
							};

						};
					in
						lib.types.attrsOf (lib.types.submoduleWith { modules = [ scrolling genericTemplate innerTemplate extraTemplate ]; });
					default = {};
				};

			};

			generics = 
			let

				innerTemplate.options = {

					scrolling.method = lib.mkOption {
						type = 
						let
							template.options.scrollButton = {
								
								id = lib.mkOption {
									type = lib.types.nullOr lib.types.ints.unsigned;
									default = null; # 0 means default
								};

								lock = lib.mkOption {
									type = lib.types.nullOr lib.types.bool;
									default = null;
								};

							};
						in
							lib.types.nullOr (lib.types.either (lib.types.enum [ "twoFingers" "edge" "none" ]) (lib.types.submoduleWith { modules = [ template ]; }));
						default = null;
						description = "If a set then scroll-button method will be used";
					};
						
				};

			in
			{

				default = lib.mkOption {
					type = 
					let
						extraTemplate.options = {

							acceleration = accelerationGenerator [ "adaptive" "flat" "none" ];

						};
					in
						lib.types.submoduleWith { modules = [ scrolling genericTemplate innerTemplate extraTemplate ]; };
					default = {};
				};

				generics = lib.mkOption {
					type = 
					let
						extraTemplate.options = {

							hardware.name = lib.mkOption {
								type = lib.types.str;
							};

							acceleration = accelerationGenerator [ "adaptive" "flat" ];

						};
					in
						lib.types.attrsOf (lib.types.submoduleWith { modules = [ scrolling genericTemplate innerTemplate extraTemplate ]; });
					default = {};
				};

			};

		};

	};

}
