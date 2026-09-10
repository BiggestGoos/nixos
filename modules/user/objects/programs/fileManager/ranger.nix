{ szy, lib, config, pkgs, ... }:
(szy config).objects.make
{

	inherits = [ [ "programs" "fileManager" ] ];
	#extends = [ "terminalApplication" ];

	name = "ranger";
	namespace = [ "programs" ];

	constant.type = "cli";

	output.config = 
	{

		programs.ranger = 
		{
			enable = true;
		};	

	};

}

