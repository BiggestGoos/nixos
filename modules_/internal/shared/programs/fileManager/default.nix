{ lib, szy, config, ... }:
szy.programs.mkProgram
{

	inherit config;
	name = "fileManager";

	additionalValues = [
		"commandGraphical"
	];

	guiAndCli = true;

}
