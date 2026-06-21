{ szy, lib, config, pkgs, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "musicPlayer";

	extends = [ "application" ];

}
