{ szy, lib, config, pkgs, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "browser";

	extends = [ "defaultApplication" ];

	defaultArguments =
	{ final, object }:
	{

		application.type = lib.mkDefault "gui";
		desktopEntry.default.required = lib.mkForce true;
		program.arguments.search.required = lib.mkForce true;

	};

	configuration =
	{ enabled, final }:
	let
	
		default = final.data.default.any.value;

	in
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
				builtins.listToAttrs (builtins.map (mimetype: { name = mimetype; value = [ default.data.desktopEntry.default.final.path ]; }) mimetypes);

		};

		"${szy}".variables = {
			"BROWSER" = default.data.commands.open.relative;
		};

	};

}
