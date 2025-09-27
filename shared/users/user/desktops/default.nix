path:
{ osConfig, szy, ... }:
{
	
	imports = if (osConfig."${szy}".desktops.enabled == null) then [] else ((builtins.map (name: (path + "/${name}")) osConfig."${szy}".desktops.enabled) ++ [ {
		_module.args.desktop = osConfig."${szy}".desktops.desktopData;
	} ]);

}
