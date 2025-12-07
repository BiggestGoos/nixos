{ config, szy, lib, desktop, pkgs, ... }:
let

	actions = config."${szy}".desktops.components.actions.resolved;

	launchPrefix = "${pkgs.uwsm}/bin/uwsm app --";

	menu = "rofi";
	menuBin = "${pkgs.rofi}/bin/rofi";
	appLauncher = "${menuBin} -show drun -show-icons -run-command '${launchPrefix} {cmd}' -run-shell-command '${launchPrefix} ${actions.programs.default.terminal.open.command} {cmd}'";

in
{

	config.wayland.windowManager.hyprland.settings = {

		gesture = lib.lists.optionals (desktop.isEnabledStrict [ "hyprland" ]) [
			"3, horizontal, workspace"
		];

		binds = {
			
			drag_threshold = lib.mkIf (desktop.isEnabledStrict [ "hyprland" ]) 10;
			allow_pin_fullscreen = true;

		};
		
		bindir = 
		lib.lists.optionals (desktop.isEnabledStrict [ "hyprland" ])
		[
			" , SUPER_L, exec, ${pkgs.procps}/bin/pkill ${menu} || ${launchPrefix} ${appLauncher}"
		];

		bind = 
		let
			mainMod = "SUPER";
		in
		(lib.lists.optionals (desktop.isEnabledStrict [ "hyprland" ])
		([
			"${mainMod}, Q, exec, ${launchPrefix} ${actions.programs.default.terminal.openGraphical.command}"
			"${mainMod}, E, exec, ${launchPrefix} ${actions.programs.default.fileManager.cli.openGraphical.command}"
			"${mainMod}, R, exec, ${launchPrefix} ${actions.programs.default.fileManager.gui.openGraphical.command}"
			"${mainMod}, D, exec, ${launchPrefix} ${actions.programs.default.browser.open.command}"

			"${mainMod}, B, togglefloating"
			"${mainMod}, F, fullscreen"
			"${mainMod}, G, togglegroup"
			"${mainMod} + CTRL, Tab, changegroupactive"

			"${mainMod} + ALT, left, workspace, -1"
			"${mainMod} + ALT, right, workspace, +1"
		] ++ (builtins.map (i: "${mainMod}, ${builtins.toString i}, workspace, ${builtins.toString i}") (builtins.genList (x: x) 10))
		  ++ (builtins.map (i: "${mainMod} + SHIFT, ${builtins.toString i}, movetoworkspace, ${builtins.toString i}") (builtins.genList (x: x) 10)))) ++ [
			", XF86AudioNext, exec, ${actions.media.next.command}"
			", XF86AudioPause, exec, ${actions.media.pause.command}"
			", XF86AudioPlay, exec, ${actions.media.playPause.command}"
			", XF86AudioPrev, exec, ${actions.media.previous.command}"
		];

		bindr = 
		let
			mainMod = "SUPER";
		in
		lib.lists.optionals (desktop.isEnabledStrict [ "hyprland" ])
		[
			"${mainMod}, W, killactive"
		];

		bindm =
		let
			mainMod = "SUPER";
		in
		lib.lists.optionals (desktop.isEnabledStrict [ "hyprland" ])
		[
			"${mainMod}, mouse:272, movewindow"
			"${mainMod}, mouse:273, resizewindow"
		];

		bindel = 
		lib.lists.optionals (config."${szy}".desktops.hyprland.options.binds.defaultsEnabled.brightness)
		[
			",XF86MonBrightnessUp, exec, ${actions.brightness.raise.command { step = 5; }}"
			",XF86MonBrightnessDown, exec, ${actions.brightness.lower.command { step = 5; }}"
		];

	};

	options."${szy}".desktops.hyprland.options.binds = {

		defaultsEnabled = {

			audio = lib.mkOption {
				type = lib.types.bool;
				default = true;
			};
			brightness = lib.mkOption {
				type = lib.types.bool;
				default = true;
			};
			media = lib.mkOption {
				type = lib.types.bool;
				default = true;
			};

		};

	};

}

