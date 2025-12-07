{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.zsh;
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
		commandGraphical = finalCommand;

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

