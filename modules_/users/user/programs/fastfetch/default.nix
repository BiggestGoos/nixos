{ lib, szy, config, ... }:
szy.programs.mkProgram
{

	inherit config;
	name = "fastfetch";

	additionalValues = [
		"commandGraphical"
	];

	singleInstance = true;
	
	configuration = 
	{ enabled, ... }:
	lib.mkIf (enabled)
	{
		programs.fastfetch.enable = true;
	};

}
