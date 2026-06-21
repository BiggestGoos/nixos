{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "package";

	name = "fastfetch";

	configuration = 
	{
		programs.fastfetch = {
			enable = true;
		};	
	};

}

