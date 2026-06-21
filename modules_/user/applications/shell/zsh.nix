{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "shell";

	name = "zsh";

	arguments = 
	{

		application.type = "cli";

		program.arguments =
		{
			runCommand.args = [ "-c" ];
			interactive.args = [ "-i" ];
		};

	};

	configuration = 
	{

		programs.zsh = {

			enable = true;

		};	

	};

}

