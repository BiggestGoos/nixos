{ pkgs, ... }:
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

			cursor = "#00cc00";
			cursor_text_color = "background";

			touch_scroll_multiplier = 5.0;

			remember_window_size = false;
			window_padding_width = 0;
			#hide_window_decorations = true;
			confirm_os_window_close = 2;

			background = "#021117";
			background_opacity = 0.9;

			kitty_mod = "ctrl+shift";

		};

		keybindings = {

			"kitty_mod+e" = "launch --type=tab --cwd=current yazi";

		};

	};

}
