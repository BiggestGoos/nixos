{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "terminal";

	name = "kitty";

	arguments = 
	{ final, object }:
	{
		commands =
		{
			open = "${final.data.commands.exec} --single-instance";
		};
	};

	configuration = 
	enabled:
	{ final, object }:
	{

		programs.kitty = enabled {
			
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

		imports = enabled [
			./tabs.nix
			./clipboard.nix
		];

	};

}

