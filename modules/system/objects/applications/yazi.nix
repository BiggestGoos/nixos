{ szy, lib, config, pkgs, ... }:
(szy config).objects.define
{

	template = "fileManager";

	name = "yazi";

	arguments.application.type = "cli";

	configuration = 
	{

		programs.yazi = {

			enable = true;

		};	

	};

}

