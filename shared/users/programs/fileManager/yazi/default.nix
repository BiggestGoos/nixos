{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.yazi;
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
		commandGraphical = finalCommand;
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

