{ szy, lib, config, pkgs, ... }:
(szy config).objects.define
{

	template = "fileManager";
	extends = [ "terminalApplication" ];

	name = "yazi";

	arguments = 
	{

		application.type = "both";

	};

	configuration = 
	{

		programs.yazi = {

			enable = true;

		};	

	};

}

