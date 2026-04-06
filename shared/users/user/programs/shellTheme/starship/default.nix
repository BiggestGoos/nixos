{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.starship;
	terminal = config."${szy}".programs.terminal.default.values.runProgram;

	shell = config."${szy}".programs.shell;
in
szy.programs.mkInstance
{

	inherit config;
	program = "shellTheme";
	name = "starship";

	values = 
	{ finalCommand, ... }:
	{
		inherit package;
	};

	configuration = 
	{ enabled, ... }:
	lib.mkIf (enabled)
	{

		programs.starship = 
		let

			shellAvailable = name: (builtins.elem name shell.available);

		in
		{

			enable = true;

			settings = import ./settings.nix { inherit lib; };

			enableZshIntegration = shellAvailable "zsh";

		};

	};

}

