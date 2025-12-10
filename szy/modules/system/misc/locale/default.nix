{ szy, lib, config, ... }:
let

	cfg = config."${szy}".locale;

in
{

	options."${szy}".locale = {

		default = lib.mkOption {
			type = lib.types.str;
			default = "en_US.UTF-8";
		};

		extra = lib.mkOption {
			type = lib.types.listOf lib.types.str;
			default = [];
		};

		settings = lib.mkOption {
			type = lib.types.attrs;
			default = {};
		};

		console.keyMap = lib.mkOption {
			type = lib.types.str;
		};

	};

	config = {

		console.keyMap = cfg.console.keyMap;

		i18n = {

			defaultLocale = cfg.default;
			extraLocales = cfg.extra;
			extraLocaleSettings = cfg.settings;

		};

	};

}
