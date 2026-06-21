{ szy, lib, config, pkgs, ... }:
(szy config).objects.define
{

	template = "package";
	extends = [ "gaming" ];

	name = "gamemode";

	configuration = 
	{ enabled, final, template }:
	{
		programs.gamemode = {
			enable = true;
		};
		"${szy}".objects.user.data.types.gaming.groups = [ "gamemode" ];	
	};

}

