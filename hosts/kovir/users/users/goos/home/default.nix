{ config, pkgs, lib, szy, osConfig, ... }:
{

	imports = [
		./desktops
		./programs
	];	
	
	home.stateVersion = "26.05";

}
