{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.neovim;
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
		commandGraphical = finalCommand;
		isGraphical = false;
	};

	configuration =	
	{ enabled, default, ... }: 
	lib.mkIf (enabled)
	{

		programs.neovim = {

			enable = true;

			defaultEditor = default;

		};	

	};

}

