{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "fileManager";
	extends = [ "terminalApplication" ];

	name = "ranger";

	arguments = 
	{ final, object }:
	{

		application.type = "both";

	};

	configuration = 
	{ enabled, final, object }:
	{

		programs.ranger = {

			enable = true;

		};	

	};

}

