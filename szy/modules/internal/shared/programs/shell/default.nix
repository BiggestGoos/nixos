{ szy, config, ... }:
szy.programs.mkProgram
{

	inherit config;
	name = "shell";

	additionalValues = [
		"commandGraphical"
		"runCommandArgument"
		"interactiveArgument"
	];

}
