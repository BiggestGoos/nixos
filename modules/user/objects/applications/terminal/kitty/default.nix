{ szy, lib, config, pkgs, ... }:
(szy config).objects.define
{

	template = "terminal";

	name = "kitty";

	arguments = 
	{

		desktopEntry.default.base.path = "kitty";

		program.bin.default.defaultArgs = [ "--single-instance" ];
		program.arguments =
		{
			runCommand.args = [ "--" ];
			remainOpen.args = [ "--hold" ];
			setDirectory.args = [ "--directory" ];
			setAppID.args = [ "--class" ];
			setTitle.args = [ "--title" ];
		};

	};

	configuration = 
	{

		programs.kitty = {
			
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

		imports = [
			./tabs.nix
			./clipboard.nix
		];

	};

}

