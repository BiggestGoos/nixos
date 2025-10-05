path:
additionalConfiguration:
{ osConfig, szy, lib, ... }:
{
	
	imports = if (osConfig."${szy}".desktops.enabled == null) then [] else ((lib.lists.flatten (builtins.map (enabledDesktopName: 
	let
		enabledDesktop = osConfig."${szy}".desktops.desktops."${enabledDesktopName}";
		paths = lib.lists.remove null (lib.lists.imap1 (i: e: 
		let
			resolvedPath = ((path + "/${(lib.strings.concatStringsSep "+" (lib.lists.take i enabledDesktop.names))}"));
		in
			(if (builtins.pathExists resolvedPath) then resolvedPath else null)) enabledDesktop.names);
	in
		paths
	) osConfig."${szy}".desktops.enabled)) ++ [ additionalConfiguration ] ++ [ {
		_module.args.desktop = osConfig."${szy}".desktops.desktopData;
	} ] ++ [  
		./options/applications
		./options/variables
	]);

}
