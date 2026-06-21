{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "fileManager";

	name = "yazi";

	arguments = 
	{ final, template }:
	{

		application.type = "cli";

	};

	configuration = 
	{ enabled, final, template }:
	{

		programs.yazi = {

			enable = true;

		};	

	};

}

