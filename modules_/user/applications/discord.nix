{ szy, lib, osConfig, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
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

