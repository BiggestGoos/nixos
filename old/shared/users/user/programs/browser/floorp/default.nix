{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.floorp-bin;
in
szy.programs.mkInstance
{

	inherit config;
	program = "browser";
	name = "floorp";

	values = 
	{ finalCommand, ... }:
	{
		inherit package;
		desktopEntry = "floorp.desktop";
		search = "${finalCommand} --search";
	};

	configuration = 
	{ enabled, optionKeys, ... }:
	szy.themes.mkThemed
	{

		path = ./.;
		inherit config enabled;

		option = optionKeys;

		themes = [ "default" ];
		defaultTheme = "default";

		configuration = {

			programs.floorp = {

				enable = true;

				profiles."${config.home.username}" = {

					id = 0;
					isDefault = true;

				};

			};

		};

	};

}
