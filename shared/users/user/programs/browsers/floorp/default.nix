{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.floorp-bin;
in
szy.variants.mkVarying
{

	path = ./.;
	inherit config;

	option = [ "browsers" "browsers" "floorp" ];

	variants = [
		"default"
	];

	defaultVariants = [
		"default"
	];

	configuration = {

		programs.floorp = {

			enable = true;

			profiles."${config.home.username}" = {

				id = 0;
				isDefault = true;

			};

		};

	};

	additionalOptions = {

		"${szy}".browsers.browsers.floorp.values = 
		let
			directory = "${package}";
			command = directory + "/bin/floorp";
			searchCommand = command + "--search";
			autostartCommand = command + "";
			desktopEntry = "floorp.desktop";
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

		};

	};

}
