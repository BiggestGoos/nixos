{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "shell";

	name = "zsh";

	arguments = 
	{ final, object }:
	{

		application.type = "cli";

		program.arguments =
		{
			runCommand.args = [ "-c" ];
			interactive.args = [ "-i" ];
		};

	};

	configuration = 
	{ enabled, final, object }:
	{

		programs.zsh = {

			enable = true;

		};	

	};

}

