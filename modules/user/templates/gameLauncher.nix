{ szy, lib, config, pkgs, ... }:
(szy config).objects.declare
{
	
	name = "gameLauncher";

	extends = [ "gaming" "application" ];

}
