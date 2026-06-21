{ lib, szy, config, ... }:
szy.programs.mkProgram
{

	inherit config;
	name = "nh";

	additionalValues = [
		"commandGraphical"
		"buildArgument"
		"switchArgument"
		"replArgument"
	];

	singleInstance = true;

	configuration = 
	{ enabled, ... }:
	lib.mkIf (enabled)
	{

		programs.nh = {
			enable = true;
			flake = szy.utils.rawRoot;
		};

	};

}
