{ szy, config, ... }:
szy.programs.mkProgram
{

	inherit config;
	name = "browser";

	additionalValues = [
		"desktopEntry"
		"autostart"
		"search"
	];

	configuration = 
	{ values }:
	{

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
				builtins.listToAttrs (builtins.map (mimetype: { name = mimetype; value = [ values.desktopEntry ]; }) mimetypes);

		};

		home.sessionVariables = {
			"BROWSER" = values.command;
		};

	};

}
