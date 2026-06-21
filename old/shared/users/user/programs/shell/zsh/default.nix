{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.zsh;
	terminal = config."${szy}".programs.terminal.default.values.runProgram;
	editor = config."${szy}".programs.editor.default.values.command;
in
szy.programs.mkInstance
{

	inherit config;
	program = "shell";
	name = "zsh";

	values = 
	{ finalCommand, ... }:
	{
		inherit package;
		commandGraphical = "${terminal} ${finalCommand}";

		runCommandArgument = commandToRun: "-c '${commandToRun}'";
		interactiveArgument = "-i";
	};

	configuration = 
	{ enabled, ... }:
	lib.mkIf (enabled)
	{

		programs.zsh = {

			enable = true;

		};

	};

}

