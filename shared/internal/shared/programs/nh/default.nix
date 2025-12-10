configuration:
{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.nh;
in
szy.programs.mkInstance
{

	inherit config;
	program = "nh";

	values = 
	{ finalCommand, ... }:
	{
		inherit package;
		buildArgument = "os build";
		switchArgument = "os switch";
		replArgument = "os repl";
	};

	inherit configuration;

}

