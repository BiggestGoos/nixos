{ desktop, config, lib, szy, ... }:
{

	imports = [
		./autologin.nix
	];

	services.displayManager.ly = 
	lib.mkIf (config."${szy}".desktops.options.autologin.enabled == false)
	{
		enable = true;
	};

}
