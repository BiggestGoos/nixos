{ szy, lib, config, pkgs, ... }:
(szy config).objects.declare
{
	
	name = "fileManager";

	extends = [ "defaultApplication" ];

}
