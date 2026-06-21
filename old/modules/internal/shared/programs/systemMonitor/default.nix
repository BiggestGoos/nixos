{ szy, config, ... }:
szy.programs.mkProgram
{

	inherit config;
	name = "systemMonitor";

	additionalValues = [
		"commandGraphical"
	];

	guiAndCli = true;

}
