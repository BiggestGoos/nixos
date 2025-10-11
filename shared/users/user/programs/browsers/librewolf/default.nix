{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.librewolf;
in
szy.themes.mkThemed
{

	path = ./.;
	inherit config;

	option = [ "browsers" "browsers" "librewolf" ];

	themes = [
		"default"
	];

	defaultTheme = "default";

	configuration = {

		programs.librewolf = {

			enable = true;

			profiles."${config.home.username}" = {

				id = 0;
				isDefault = true;

			};

		};

	};

	additionalOptions = {

		"${szy}".browsers.browsers.librewolf.values = 
		let
			directory = "${package}";
			command = directory + "/bin/librewolf";
			searchCommand = command + " --search";
			autostartCommand = command + "";
			desktopEntry = "librewolf.desktop";
		in
		{

			command = lib.mkOption {
				type = lib.types.str;
				default = command;
			};

			autostartCommand = lib.mkOption {
				type = lib.types.str;
				default = autostartCommand;
			};

			searchCommand = lib.mkOption {
				type = lib.types.str;
				default = searchCommand;
			};

			desktopEntry = lib.mkOption {
				type = lib.types.str;
				default = desktopEntry;
			};

			package = lib.mkOption {
				type = lib.types.package;
				default = pkgs.librewolf;
			};

		};

	};

}
