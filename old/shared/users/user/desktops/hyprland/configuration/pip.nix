{ ... }:
{

/*

# Picture-in-Picture for Floorp (Firefox). Floats and pins
$pip = title:^(Picture-in-Picture)$
windowrule = float, $pip
windowrule = pin, $pip
windowrule = content video, $pip
windowrule = noinitialfocus, $pip
windowrule = size 30% 30%, $pip
windowrule = move 100%-w-0, $pip
windowrule = bordersize 1, $pip
windowrule = keepaspectratio, $pip

*/

	wayland.windowManager.hyprland.settings = 
	let
		pip = "title:^(Picture-in-Picture)$";
	in
	{



		windowrule = [
			{
				name = "pip";

				"match:title" = "^(Picture-in-Picture)$";

				float = "on";
				pin = "on";
				content = "video";
				no_initial_focus = "on";
				size = "30% 30%";
				move = "100%-w-0";
				border_size = 1;
				keep_aspect_ratio = "on";

			}
		];

	};

}
