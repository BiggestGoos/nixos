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
	{ command }:
	{
		inherit package;
		desktopEntry = "floorp.desktop";
		autostart = command;
		search = "${command} --search";
	};

	configuration = 
	{ optionKeys, ... }:
	szy.themes.mkThemed
	{

		path = ./.;
		inherit config;

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
