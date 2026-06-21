{ szy, lib, osConfig, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "application";

	name = "anki";

	arguments = 
	{
		application.type = "gui";
	};

	configuration = 
	{ enabled, final, template }:
	{
		home.packages = [ final.data.package ];
	};

}

