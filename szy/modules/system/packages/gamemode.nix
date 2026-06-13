{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "package";
	extends = [ "gaming" ];

	name = "gamemode";

	configuration = 
	{ enabled, final, object }:
	{
		programs.gamemode = {
			enable = true;
		};
		"${szy}".users.types.groups.normal = [ "gamemode" ];
	};

}

