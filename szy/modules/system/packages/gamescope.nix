{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "package";
	extends = [ "gaming" ];

	name = "gamescope";

	configuration = 
	{ enabled, final, template }:
	{
		programs.gamescope = {
			enable = true;
		};	
	};

}

