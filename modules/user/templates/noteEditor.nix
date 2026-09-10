{ szy, lib, config, pkgs, ... }:
(szy config).objects.make.template
{

	name = "noteEditor";
	namespace = [ "programs" ];

	inherits = [ "application" ];

}
