{ szy, lib, config, pkgs, ... }:
(szy config).objects.make.template
{
	
	name = "gameLauncher";
	namespace = [ "programs" ];

	inherits = [ "gaming" "application" ];

}
