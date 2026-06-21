{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.starship;
	terminal = config."${szy}".programs.terminal.default.values.runProgram;

	shells = config."${szy}".applications.shell or {};
	
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

			shellEnabled = shell: (shells."${shell}" or { enabled = false; }).enabled;

		in
		{

			enable = true;

			settings = import ./settings.nix { inherit lib; };

			enableZshIntegration = shellEnabled "zsh";

		};

	};

}

