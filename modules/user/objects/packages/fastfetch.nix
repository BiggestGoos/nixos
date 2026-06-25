{ szy, lib, config, pkgs, ... }:
(szy config).objects.define
{

	template = "package";

	name = "fastfetch";

	configuration = 
	{
		programs.fastfetch = {
			enable = true;
		};	
	};

}

