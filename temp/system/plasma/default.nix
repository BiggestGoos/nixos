{ config, szy, pkgs, lib, ... }:
{

	services.desktopManager.plasma6.enable = true; 
	
	imports = 
	[
		./config.nix
	];

}
