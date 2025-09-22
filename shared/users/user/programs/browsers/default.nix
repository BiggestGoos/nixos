{ szy, lib, config, ... }:
{

	options."${szy}".browsers = {

		available = lib.mkOption {
			type = lib.types.listOf lib.types.str;
			readOnly = true;
			default = builtins.attrNames config."${szy}".browsers.browsers;
		};

		default = lib.mkOption {
			type = lib.types.enum (config."${szy}".browsers.available);
		};

		defaultValues = 
		let
			default = config."${szy}".browsers.default;
			values = config."${szy}".browsers.browsers."${default}".values;
		in
		{

			command = lib.mkOption {
				type = lib.types.str;
				default = values.command or "";
			};

			autostartCommand = lib.mkOption {
				type = lib.types.str;
				default = values.autostartCommand or "";
			};

			searchCommand = lib.mkOption {
				type = lib.types.str;
				default = values.searchCommand or "";
			};

			desktopEntry = lib.mkOption {
				type = lib.types.str;
				default = values.desktopEntry or "";
			};

		};

	};

	config = {

		xdg.mimeApps = {

			enable = true;

			defaultApplications = 
			let
				mimetypes = [
					"default-web-browser"
					"text/html"
					"x-scheme-handler/http"
					"x-scheme-handler/https"
					"x-scheme-handler/about"
					"x-scheme-handler/unknown"
				];
			in
				builtins.listToAttrs (builtins.map (mimetype: { name = mimetype; value = [ config."${szy}".browsers.defaultValues.desktopEntry ]; }) mimetypes);

		};

		home.sessionVariables = {
			"BROWSER" = config."${szy}".browsers.defaultValues.command;
		};

	};

}
