{ config, szy, osConfig, lib, ... }:
let
	configDir = "${config.xdg.configHome}/uwsm";

	resolvedDefault = szy.utils.mergeAll [ osConfig."${szy}".desktops.options.variables.default config."${szy}".desktops.options.variables.default ];
	resolvedHyprland = szy.utils.mergeAll [ (osConfig."${szy}".desktops.options.variables.variables.hyprland or {}) (config."${szy}".desktops.options.variables.variables.hyprland or {}) ];
in
{
	
	home.file."${configDir}/env".text = lib.strings.concatStringsSep "\n" (lib.attrsets.mapAttrsToList (name: value: ("export ${name}=${value}")) resolvedDefault);

	home.file."${configDir}/env-hyprland".text = lib.strings.concatStringsSep "\n" (lib.attrsets.mapAttrsToList (name: value: ("export ${name}=${value}")) resolvedHyprland);
	
	#.source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

	/*
	{
		text = 
		''
		
			# Uwsm environment
	
			# Cursor
			export XCURSOR_SIZE=24

			# Steam
			export STEAM_FORCE_DESKTOPUI_SCALING=1.25
		'';
		
	};*/

	#home.file."${configDir}/env-hyprland".text = 

	/*{
		text = 
		''
			
			# Uwsm environment hyprland

			# Cursor
			export HYPRCURSOR_SIZE=24

		'';
	};*/

}
