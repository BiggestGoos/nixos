{ szy, lib, config, pkgs, ... }:
(szy config).objects.make
{

	inherits = [ [ "programs" "editor" ] ];

	name = "neovim";
	namespace = [ "programs" ];

	constant.type = "cli";

	output.config = 
	{

		programs.neovim = 
		{
			enable = true;	
		};	

	};

}

