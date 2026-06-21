{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
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

