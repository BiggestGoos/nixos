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
			"float, ${pip}"
			"pin, ${pip}"
			"content video, ${pip}"
			"noinitialfocus, ${pip}"
			"size 30% 30%, ${pip}"
			"move 100%-w-0, ${pip}"
			"bordersize 1, ${pip}"
			"keepaspectratio, ${pip}"
		];

	};

}
