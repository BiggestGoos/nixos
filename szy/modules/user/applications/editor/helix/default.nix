{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "editor";
	extends = [ "terminalApplication" ];

	name = "helix";

	arguments =
	{ final, object }:
	{
	
		desktopEntry.default.base.path = "Helix";

	};

	configuration = 
	{ enabled, final, object }:
	{

		programs.helix = {

			enable = true;

			defaultEditor = { inherit (object.data.default.cli) name template; } == { inherit (final.meta) name template; };

		};

	};

}

