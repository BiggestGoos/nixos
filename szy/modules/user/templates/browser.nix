{ szy, lib, config, pkgs, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "browser";

	extends = [ "application" "default" ];

	parameters =
	{ final, object }:
	{

		commands = 
		{
			search = lib.options.mkOption { type = lib.types.str; };
		};

	};

	configuration =
	enabled:
	{ final }:
	let

		defaultValue = final.data.default;

		default = 
		let
			easy = final.definitions."${final.data.default}";
			hard = szy.objects.helper.getDefinition ({ inherit config; } // defaultValue);
		in
			if (builtins.isString defaultValue) then easy else hard;

	in
	enabled
	{

		programs.firefox.enable = true;

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
			"BROWSER" = default.data.commands.exec;
		};

	};

}
