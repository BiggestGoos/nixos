{ osConfig, config, szy, lib, desktop, pkgs, ... }:
let

	displays = osConfig."${szy}".desktops.components.displays.displays;

in
{

	wayland.windowManager.hyprland.settings = {

		monitor = [
			" , preferred, auto, 1"
		] ++ (lib.attrsets.mapAttrsToList (name: display: 
		let
			identifier = if (display.hardware.description == null) then display.hardware.portName else "desc:${display.hardware.description}";
			modeline = display.modeline;
			displayMode = 
			let
				presetMap = {
					preferred = "preferred";
					highResolution = "highres";
					highRefreshRate = "highrr";
					maxWidth = "maxwidth";
				};
			in
				if (modeline == null) then (if (builtins.isString display.displayMode == false) then "${builtins.toString display.displayMode.resolution.width}x${builtins.toString display.displayMode.resolution.height}@${builtins.toString display.displayMode.refreshRate}" else presetMap."${display.displayMode}") else "modeline ${modeline}";
			position = if (builtins.isString display.position == false) then "${builtins.toString display.position.x}x${builtins.toString display.position.y}" else display.position;
			scale = builtins.toString display.scale;
			transform = "transform, ${builtins.toString display.transform}";
			mirror = if (display.mirror == null) then "" else ", mirror, ${osConfig."${szy}".desktops.components.displays.displays."${display.mirror}".hardware.portName}";
		in
			"${identifier}, ${displayMode}, ${position}, ${scale}, ${transform}${mirror}"
		) displays);
		
	};

}
