{ desktop, lib, config, ... }:
let

	activeOpacity = 0.9;
	inactiveOpacity = 0.75;

in
{

	wayland.windowManager.hyprland.settings = lib.mkIf (desktop.isEnabledStrict [ "hyprland" ]) {

		general = {

			gaps_in = 1;
			gaps_out = 4;
			gaps_workspaces = 50;

			border_size = 4;

			"col.inactive_border" = "rgba(10309045) rgba(90203045) 135deg";
			"col.active_border" = "rgba(e0208070) rgba(f020ff70) 45deg";

			resize_corner = 1;

			snap = {

				enabled = true;

				window_gap = 20;
				monitor_gap = 20;

				border_overlap = false;

			};

			layout = "dwindle";

		};

		dwindle = {
			
			pseudotile = true;
			preserve_split = true;

		};

		master = {

			new_status = "master";
			mfact = 0.7;
			orientation = "left";

		};

		decoration = {

			rounding = 10;
			rounding_power = 2;

			active_opacity = activeOpacity;
			inactive_opacity = inactiveOpacity;
			fullscreen_opacity = 1.0;

			dim_inactive = true;
			dim_strength = 0.05;
			dim_special = 0.4;

			blur = {

				enabled = true;

				size = 8;
				passes = 1;

				noise = 0.15;
				vibrancy = 1.0;
				vibrancy_darkness = 0.5;

			};

			shadow = {
				
				enabled = true;

				range = 3;
				render_power = 2;

				color = "rgba(50703040)";
				color_inactive = "rgba(aaaaaa20)";

			};
		};

		# I feel like this should actually be something that the individual program does and not something that should be here.
		windowrule = [
			{

				name = "kitty opacity";
				"match:class" = "^(kitty)$";

				opacity = "1.0 override ${builtins.toString (inactiveOpacity / activeOpacity)} override";

			}
		];

	};

}
