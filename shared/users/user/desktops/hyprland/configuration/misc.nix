{ ... }:
{

	imports = [
		./pip.nix
	];

	wayland.windowManager.hyprland.settings = {

		misc = {

			force_default_wallpaper = 0;

			middle_click_paste = false;

			mouse_move_enables_dpms = true;
			key_press_enables_dpms = true;

		};

		render.direct_scanout = 2;

		xwayland = {

			enabled = true;
			use_nearest_neighbor = false;
			force_zero_scaling = true;

		};

		group.drag_into_group = 2;

		windowrule = [
			# Ignore maximize requests from apps. You'll probably like this.
			"suppressevent maximize, class:.*"
			# Fix some dragging issues with XWayland
			"nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
		];

	};

}
