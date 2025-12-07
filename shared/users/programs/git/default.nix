{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.git;
in
szy.programs.mkInstance
{

	inherit config;
	program = "git";

	values = 
	{
		inherit package;
	};

}

