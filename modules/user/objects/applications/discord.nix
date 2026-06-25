{ szy, lib, osConfig, config, pkgs, ... }:
(szy config).objects.define
{

	template = "application";

	name = "discord";

	arguments = 
	{
		application.type = "gui";
	};

	configuration = 
	{
		programs.discord.enable = true;
	};

}

