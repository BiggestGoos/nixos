{ config, szy, pkgs, lib, ... }:
{
	
	programs = 
	{

		hyprland = 
		{
			enable = true;
			withUWSM = true;
		};

		uwsm.enable = true;

	};
	
	imports = 
	[
		./displayManager.nix
		./xdgPortal.nix
	];

}
