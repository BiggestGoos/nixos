{ config, szy, lib, desktop, pkgs, ... }:
let

	applications = config."${szy}".desktops.options.applications;

	launchPrefix = "${pkgs.uwsm}/bin/uwsm app --";

	menu = "rofi";
	menuBin = "${pkgs.rofi}/bin/rofi";
	appLauncher = "${menuBin} -show drun -show-icons -run-command '${launchPrefix} {cmd}' -run-shell-command '${launchPrefix} ${applications.terminalEmulator.command} -e {cmd}'";

in
{

	wayland.windowManager.hyprland.settings = {

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
		lib.lists.optionals (desktop.isEnabledStrict [ "hyprland" ])
		([
			"${mainMod}, Q, exec, ${launchPrefix} ${applications.terminalEmulator.command}"
			"${mainMod}, E, exec, ${launchPrefix} ${applications.terminalEmulator.command} ${applications.fileManager.command}"
			"${mainMod}, R, exec, ${launchPrefix} ${applications.fileManagerGui.command}"
			"${mainMod}, D, exec, ${launchPrefix} ${applications.browser.command}"

			"${mainMod}, B, togglefloating"
			"${mainMod}, F, fullscreen"
			"${mainMod}, G, togglegroup"
			"${mainMod} + CTRL, Tab, changegroupactive"

			"${mainMod} + ALT, left, workspace, -1"
			"${mainMod} + ALT, right, workspace, +1"
		] ++ (builtins.map (i: "${mainMod}, ${builtins.toString i}, workspace, ${builtins.toString i}") (builtins.genList (x: x) 10))
		  ++ (builtins.map (i: "${mainMod} + SHIFT, ${builtins.toString i}, movetoworkspace, ${builtins.toString i}") (builtins.genList (x: x) 10)));

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

	};

}
