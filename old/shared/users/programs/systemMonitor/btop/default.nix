{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.btop;
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
		commandGraphical = finalCommand;
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

