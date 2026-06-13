{ szy, lib, osConfig, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "application";

	name = "anki";

	arguments = 
	{ final, object }:
	{
		application.type = "gui";
	};

	configuration = 
	{ enabled, final, object }:
	{
		home.packages = [ final.data.package ];
	};

}

