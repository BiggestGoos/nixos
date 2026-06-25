{ szy, lib, osConfig, config, pkgs, ... }:
(szy config).objects.define
{

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

