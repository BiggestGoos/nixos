{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
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
			
			extest.enable = true;

			extraCompatPackages = [
				pkgs.proton-ge-bin
			];

		};

	};

}

