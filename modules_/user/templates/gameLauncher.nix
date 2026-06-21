{ szy, lib, config, pkgs, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "gameLauncher";

	extends = [ "gaming" "application" ];

}
