{ lib, config, ... }:
{

	imports = [
		./floorp
		./librewolf
	];

	options.browsers = {

		enable = lib.mkEnableOption "browsers";

		default = lib.mkOption {

			type = lib.types.submodule {
				options.command = lib.mkOption {
					type = lib.types.str;
					default = "";
				};
				options.desktopName = lib.mkOption {
					type = lib.types.str;
					default = "";
				};
			};
		};

	};

	config = {

		browsers = {
			enable = true;

			default = {
				command = "floorp";
				desktopName = "floorp.desktop";
			};

		};

		xdg.mimeApps = {

			enable = true;

			defaultApplications = 
			let
				mimetypes = [
					"text/html"
					"x-scheme-handler/http"
					"x-scheme-handler/https"
					"x-scheme-handler/about"
					"x-scheme-handler/unknown"
				];
			in
				builtins.listToAttrs (builtins.map (mimetype: { name = mimetype; value = [ config.browsers.default.desktopName ]; }) mimetypes);

		};

	};

}
