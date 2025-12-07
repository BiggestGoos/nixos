{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.yazi;
	terminal = config."${szy}".programs.terminal.default.values.runProgram;
in
szy.programs.mkInstance
{

	inherit config;
	program = "fileManager";
	name = "yazi";

	values = 
	{ finalCommand, ... }:
	{
		inherit package;
		commandGraphical = "${terminal} ${finalCommand}";
		isGraphical = false;
	};

	configuration =	
	{ enabled, default, ... }: 
	lib.mkIf (enabled)
	{

		programs.yazi = {

			enable = true;

		};	

	};

}

