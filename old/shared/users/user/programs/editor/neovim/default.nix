{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.neovim;
	terminal = config."${szy}".programs.terminal.default.values.runProgram;
in
szy.programs.mkInstance
{

	inherit config;
	program = "editor";
	name = "neovim";

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

		programs.neovim = {

			enable = true;

			extraConfig = ''
		
				hi Normal ctermbg=none guibg=none

				set number

				set tabstop=4
				set shiftwidth=4

			'';

			defaultEditor = default;

		};	

	};

}

