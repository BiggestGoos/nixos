enabled:
{ szy, config, lib, ... }:
let

	clipboardMod = "ctrl+shift+";

	keybindings = {

		"${clipboardMod}c" = "copy_to_clipboard";
		"${clipboardMod}v" = "paste_from_clipboard";

	};

in
enabled
{

	programs.kitty = {

		inherit keybindings;

	};

}
