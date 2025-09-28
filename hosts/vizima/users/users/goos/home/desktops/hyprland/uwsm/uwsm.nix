{ config, szy, ... }@args:
let
	configDir = "uwsm";
	configHomeDir = "${config.xdg.configHome}/${configDir}";
in
{
	
	home.file."${configHomeDir}/env" = {
		text = 
		''
		
			# Uwsm environment

			export XDG_CURRENT_DESKTOP=Hyprland

			# Cursor
			export XCURSOR_SIZE=24

			# Toolkits use wayland
			export GDK_BACKEND=wayland,x11,*
			export QT_QPA_PLATFORM=wayland;xcb
			export SDL_VIDEODRIVER=wayland
			export CLUTTER_BACKEND=wayland

			# Qt
			export QT_AUTO_SCREEN_SCALE_FACTOR=1

			# Electron
			export ELECTRON_OZONE_PLATFORM_HINT=auto

			# Steam
			export STEAM_FORCE_DESKTOPUI_SCALING=1.25
		'';
		
			/*# Nix-wayland
			export NIXOS_OZONE_WL=1*/
		
	};

	home.file."${configHomeDir}/env-hyprland" = {
		text = 
		''
			
			# Uwsm environment hyprland

			# Cursor
			export HYPRCURSOR_SIZE=24

		'';
	};

}
