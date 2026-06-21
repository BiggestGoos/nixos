{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.nemo;
in
szy.programs.mkInstance
{

	inherit config;
	program = "fileManager";
	name = "nemo";

	values = 
	{ finalCommand, ... }:
	{
		inherit package;
		commandGraphical = finalCommand;
		isGraphical = true;
	};

	configuration =	
	{ enabled, default, ... }: 
	lib.mkIf (enabled)
	{

		home.packages = [
			package
		];

	};

}

