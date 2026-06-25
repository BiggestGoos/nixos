{ szy, lib, osConfig, config, pkgs, ... }:
(szy config).objects.define
{

	template = "application";

	name = "bitwarden";

	arguments = 
	{
		application.type = "gui";
		package = pkgs.bitwarden-desktop;
	};

	configuration = 
	{ final, ... }:
	{
		home.packages = [ final.data.package ];
	};

}

