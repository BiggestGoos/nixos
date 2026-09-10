{ szy, lib, osConfig, config, pkgs, ... }:
(szy config).objects.make
{

	inherits = [ "application" ];

	name = "bitwarden";
	namespace = [ "programs" ];
	
	constant.type = "gui";

	variable.program.package.input = pkgs.bitwarden-desktop;

	output.config = 
	{ constant, ... }:
	{
		home.packages = [ constant.program.package.final ];
	};

}

