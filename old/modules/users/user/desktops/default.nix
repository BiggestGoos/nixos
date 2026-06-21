{ config, osConfig, szy, lib, ... }:
{
	
	imports = ([ {
		_module.args.desktop = osConfig."${szy}".desktops.desktopData;
	} ] ++ [ ./components ]);

}
