{ szy, lib, config, pkgs, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "terminal";

	extends = [ "defaultApplication" ];

	parameters =
	{ final, object }:
	{

		commands = 
		{
			runCommand = lib.options.mkOption
			{
				type = lib.types.functionTo lib.types.str;
				default = command: "${final.data.commands.open} ${command}";
			};
		};

	};

	defaultArguments =
	{ final, object }:
	{

		application.type = lib.mkForce "gui";
		desktopEntry =
		{

			required = lib.mkForce true;

			overrides.implements =
			[
				"org.freedesktop.Terminal1"
			];

		};

	};

	configuration =
	enabled:
	{ final }:
	enabled
	{

		xdg.terminal-exec =
		{
			enable = true;
			settings =
			{
				default = 
				[
					#"com.mitchellh.ghostty.desktop"
					"${final.data.default.any.value.data.desktopEntry.final.values.name}.desktop"
				];
			};
		};

	};

}
