{ szy, lib, config, pkgs, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "noteEditor";

	extends = [ "application" ];

}
