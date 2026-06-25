{ szy, lib, config, pkgs, ... }:
(szy config).objects.declare
{
	
	name = "musicPlayer";

	extends = [ "application" ];

}
