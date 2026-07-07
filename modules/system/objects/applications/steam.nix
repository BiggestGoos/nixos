{ szy, lib, config, pkgs, ... }:
(szy config).objects.define
{

	template = "application";
	extends = [ "gaming" ];

	name = "steam";

	arguments = 
	{ final, template }:
	{

		package = config.programs.steam.package;
		application.type = "gui";

	};

	configuration = 
	{ enabled, final, template }:
	{

		programs.steam = 
		{
		
			enable = true;
			
			remotePlay.openFirewall = true;

			extest.enable = true;

			extraCompatPackages = [
				pkgs.proton-ge-bin
			];

		};

	};

}

