{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.kitty;
in
szy.programs.mkInstance
{

	inherit config;
	program = "terminal";
	name = "kitty";

	values = 
	{ command, finalCommand, ... }:
	{
		inherit package;
		desktopEntry = "kitty.desktop";
		command = "${command} --single-instance";
		runProgram = finalCommand;
	};

	configuration = 
	{ enabled, optionKeys, ... }:
	{

		programs.kitty = lib.mkIf enabled {
			enable = true;

			themeFile = "adwaita_darker";

			font = {

				size = 10;
				package = pkgs.nerd-fonts.fira-code;
				name = "FiraCode Nerd Font Mono";

			};

			settings = {

				disable_ligatures = "cursor";

				# In future, use global theme colors for styling (colors, opacity, etc...)
				cursor = "#00cc00";
				cursor_text_color = "background";

				# Should follow the used desktops input values in some way
				touch_scroll_multiplier = 5.0;

				remember_window_size = false;
				window_padding_width = 0;
				#hide_window_decorations = true;
				confirm_os_window_close = 2;

				background = "#021117";
				background_opacity = 0.9;

				clear_all_shortcuts = true;	

			};

		};

		imports = szy.import.toggleable enabled [
			./tabs.nix
			./clipboard.nix
		];

	};

}

