{ desktop, config, lib, szy, ... }:
{

	imports = [
		./autologin.nix
	];

	services.displayManager.ly = 
	lib.mkIf ((desktop.isDefaultStrict [ "hyprland" ]) && (config."${szy}".desktops.components.autologin.enabled == false))
	{
		enable = true;
	};

}
