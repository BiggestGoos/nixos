{ config, pkgs, lib, szy, osConfig, ... }:
{

	imports = [
		./desktops
		./programs
	];	
	
	home.stateVersion = "25.11";

}
