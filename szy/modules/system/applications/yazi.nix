{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "fileManager";
	extends = [ "terminalApplication" ];

	name = "yazi";

	arguments = 
	{ final, object }:
	{

		application.type = "cli";

	};

	configuration = 
	{ enabled, final, object }:
	{

		programs.yazi = {

			enable = true;

		};	

	};

}

