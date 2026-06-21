{ szy, lib, config, pkgs, ... }:
(szy config).objects.define
{

	template = "shell";

	name = "zsh";

	arguments = 
	{

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

