{ szy, lib, config, pkgs, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "terminal";

	extends = [ "defaultApplication" ];

	templateArguments =
	{ final }:
	{

		defaultTypes = 
		{
			gui = definition: true;
			any = definition: { inherit (definition.meta) name template; } == { inherit (final.data.default.gui) name template; };
		};

	};

	defaultArguments =
	{ final, object }:
	{

		application.type = lib.mkForce "gui";
		program.arguments.runCommand.required = lib.mkForce true;
		desktopEntry.runCommand =
		{

			required = lib.mkForce true;

			overrides = 
			{
				exec = lib.mkDefault final.data.commands.open.relative;
				name = lib.mkDefault "${final.meta.name}RunCommand";
				noDisplay = true;
				desktopName = "${final.meta.name} runCommand";
				extraConfig."X-TerminalArgExec" = lib.strings.concatStringsSep " " final.data.program.arguments.runCommand.args;
			};

		};

	};

	configuration =
	{ enabled, final }:
	let
		default = final.data.default.any.value;
	in
	{

		xdg.terminal-exec =
		{
			enable = true;
			settings =
			{
				default = 
				[
					default.data.desktopEntry.default.final.id
				];
			};
		};

	};

}
