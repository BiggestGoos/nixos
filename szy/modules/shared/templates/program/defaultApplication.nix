{ szy, lib, config, pkgs, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "defaultApplication";
	enable = true;

	extends = [ "application" "default" ];

	templateArguments =
	{ final }:
	{

		defaultTypes = 
		lib.mkDefault
		{
			any = definition: true;
			gui = definition: definition.data.application.type != "cli";
			cli = definition: definition.data.application.type != "gui";
		};

		default.any =
		let
			inherit (final.data.default) gui cli;
			hasGui = gui.value != null;
			hasCli = cli.value != null;
		in
		(lib.mkIf (hasGui) { inherit (gui) name template; }) //
		(lib.mkIf (!hasGui && hasCli) { inherit (cli) name template; });

	};

	configuration =
	enabled:
	{ final }:
	{

		imports =
		[
			./applicationsOption.nix
		];

	};

}
