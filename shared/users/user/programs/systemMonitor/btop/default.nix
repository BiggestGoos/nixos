{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.btop;
	terminal = config."${szy}".programs.terminal.default.values.runProgram;
in
szy.programs.mkInstance
{

	inherit config;
	program = "systemMonitor";
	name = "btop";

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

		programs.btop = {

			enable = true;

		};	

	};

}

