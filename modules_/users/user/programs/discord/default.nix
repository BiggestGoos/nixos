{ lib, szy, config, ... }:
szy.programs.mkProgram
{

	inherit config;
	name = "discord";

	singleInstance = true;

	additionalValues = [
		"autostart"
		"silentArgument"
	];
	
}
