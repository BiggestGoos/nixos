{ szy, lib, config, pkgs, ... }:
(szy config).users.user.create "goos" true
{

	arguments =
	{

		modules = szy.lib.imports.recursive ./home;
	
	};

}
