{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "fileManager";
	extends = [ "terminalApplication" ];

	name = "ranger";

	arguments = 
	{ final, template }:
	{

		application.type = "both";

	};

	configuration = 
	{ enabled, final, template }:
	{

		programs.ranger = {

			enable = true;

		};	

	};

}

