{ szy, lib, config, pkgs, ... }:
(szy config).objects.define
{

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

