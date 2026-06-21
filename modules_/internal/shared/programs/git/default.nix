{ lib, szy, config, ... }:
szy.programs.mkProgram
{

	inherit config;
	name = "git";

	singleInstance = true;

	configuration = 
	{ enabled, ... }:
	lib.mkIf (enabled)
	{

		programs.git.enable = true;

	};

}
