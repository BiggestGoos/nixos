{ szy, lib, config, pkgs, ... }:
(szy config).objects.make.template
{
	
	name = "musicPlayer";
	namespace = [ "programs" ];

	inherits = [ "application" ];

}
