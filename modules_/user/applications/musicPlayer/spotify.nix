{ szy, lib, osConfig, config, pkgs, ... }:
szy.objects.define
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

