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

			# Steam
			export STEAM_FORCE_DESKTOPUI_SCALING=1.25
		'';
		
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
