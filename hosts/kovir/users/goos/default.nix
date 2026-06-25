{ szy, lib, config, pkgs, ... }:
(szy config).users.user.create "goos" true
{

	enable = true;

	arguments =
	{

		path = ./home;	
	
	};

	configuration =
	{	
		imports = szy.lib.imports.recursive ./mounts;
	};

}
