{ lib, desktop, ... }:
{

	wayland.windowManager.hyprland.settings = {

		input = {

			kb_layout = "se";

			touchpad = {

				scroll_factor = 0.25;
				middle_button_emulation = false;
				clickfinger_behavior = true;

			};
		};

		gesture = lib.lists.optionals (desktop.isEnabledStrict [ "hyprland" ]) [
			"3, horizontal, workspace"
		];

		binds = {
			
			drag_threshold = 10;
			allow_pin_fullscreen = true;

		};
		
		bindir = [
			" , SUPER_L, exec, pkill rofi || uwsm app -- rofi -show drun"
		];

		bind = 
		let
			mainMod = "SUPER";
			launchPrefix = "uwsm app -- ";
			mkBind = { modifier, key, dispatcher, parameter }:
				"${modifier}, ${key}, ${dispatcher}, ${parameter}";

			mkBindDefault = { key, parameter }:
				mkBind { modifier = mainMod; inherit key; dispatcher = "exec"; parameter = launchPrefix + parameter; };
		in
		[
			(mkBind { modifier = mainMod; key = "space"; dispatcher = "exec"; parameter = "pkill rofi || uwsm app -- rofi -show drun"; })
		];

	};

}
