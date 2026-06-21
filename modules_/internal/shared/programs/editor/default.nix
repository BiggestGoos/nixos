{ lib, szy, config, ... }:
szy.programs.mkProgram
{

	inherit config;
	name = "editor";

	additionalValues = [
		"commandGraphical"
	];

	guiAndCli = true;

}
