{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.starship;
	terminal = config."${szy}".programs.terminal.default.values.runProgram;
in
szy.programs.mkInstance
{

	inherit config;
	program = "shellTheme";
	name = "starship";

	values = 
	{ finalCommand, ... }:
	{
		inherit package;
	};

	configuration = 
	{ enabled, ... }:
	lib.mkIf (enabled)
	{

		programs.starship = {

			enable = true;

		};

	};

}

