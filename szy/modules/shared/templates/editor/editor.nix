{ szy, lib, config, pkgs, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "editor";

	extends = [ "defaultApplication" ];

}
