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
	{ finalCommand, ... }:
	{
		inherit package;
		desktopEntry = "librewolf.desktop";
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
