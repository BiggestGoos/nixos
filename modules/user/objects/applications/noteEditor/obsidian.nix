{ szy, lib, osConfig, config, pkgs, ... }:
(szy config).objects.define
{

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

