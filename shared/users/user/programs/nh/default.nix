{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.nh;
	terminal = config."${szy}".programs.terminal.default.values.runProgram;
in
szy.programs.mkInstance
{

	inherit config;
	program = "nh";

	values = 
	{ finalCommand, ... }:
	{
		inherit package;
		commandGraphical = "${terminal} ${finalCommand}";
		buildArgument = "os build";
		switchArgument = "os switch";
		replArgument = "os repl";
	};

}

