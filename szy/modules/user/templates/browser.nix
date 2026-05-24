{ szy, lib, config, pkgs, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "browser";

	extends = [ "defaultApplication" ];

	parameters =
	{ final, object }:
	{

		commands = 
		{
			search = lib.options.mkOption { type = lib.types.str; };
		};

	};

	defaultArguments =
	{ final, object }:
	{

		application.type = lib.mkDefault "gui";

	};

	configuration =
	enabled:
	{ final }:
	let
	
		default = final.data.default.gui.value;

	in
	enabled
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
				builtins.listToAttrs (builtins.map (mimetype: { name = mimetype; value = [ default.data.application.desktopEntry ]; }) mimetypes);

		};

		home.sessionVariables = {
			"BROWSER" = default.data.commands.open;
		};

	};

}
