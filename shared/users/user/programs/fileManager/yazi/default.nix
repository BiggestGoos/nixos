{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.yazi;
	terminal = config."${szy}".programs.terminal.default.values.runProgram;
in
szy.programs.mkInstance
{

	inherit config;
	program = "fileManager";
	name = "yazi";

	values = 
	{ finalCommand, ... }:
	{
		inherit package;
		commandGraphical = "${terminal} ${finalCommand}";
		isGraphical = false;
	};

	configuration =	
	{ enabled, default, ... }: 
	lib.mkIf (enabled)
	{

		programs.yazi = {

			enable = true;

			/*
				The default value of `programs.yazi.shellWrapperName` has changed from `yy` to `y`.
                    You are currently using the legacy default (`yy`) because `home.stateVersion` is less than "26.05".
                    To silence this warning and keep legacy behavior, set:
                      programs.yazi.shellWrapperName = "yy";
                    To adopt the new default behavior, set:
                      programs.yazi.shellWrapperName = "y";
			*/
			shellWrapperName = "y";

		};	

	};

}

