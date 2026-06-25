{ szy, lib, config, pkgs, ... }:
(szy config).objects.declare
{

	name = "noteEditor";

	extends = [ "application" ];

}
