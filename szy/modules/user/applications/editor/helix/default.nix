{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "editor";
	extends = [ "terminalApplication" ];

	name = "helix";

	arguments =
	{ final, template }:
	{
	
		desktopEntry.default.base.path = "Helix";

	};

	configuration = 
	{ enabled, final, template }:
	{

		programs.helix = {

			enable = true;

			defaultEditor = template.data.default.cli.identifier == final.meta.identifier;

		};

	};

}

