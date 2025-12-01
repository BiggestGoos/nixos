{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.librewolf;
in
szy.programs.mkInstance
{

	inherit config;
	program = "browser";
	name = "librewolf";

	values = 
	{ command }:
	{
		inherit package;
		desktopEntry = "librewolf.desktop";
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

			programs.librewolf = {

				enable = true;

				profiles."${config.home.username}" = {

					id = 0;
					isDefault = true;

				};

			};

		};

	};

}
