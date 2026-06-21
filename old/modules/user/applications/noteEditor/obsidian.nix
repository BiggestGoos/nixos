{ szy, lib, osConfig, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "noteEditor";

	name = "obsidian";
	
	arguments =
	{
		application.type = "gui";
	};

	configuration = 
	{
		programs.obsidian.enable = true;
	};

}

