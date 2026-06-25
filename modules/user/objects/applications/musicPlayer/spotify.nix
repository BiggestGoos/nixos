{ szy, lib, osConfig, config, pkgs, ... }:
(szy config).objects.define
{

	inherit config;
	template = "musicPlayer";

	name = "spotify";
	
	arguments =
	{
		application.type = "gui";
	};

	configuration = 
	{ final, ... }:
	{
		home.packages = [ final.data.package ];
	};

}

