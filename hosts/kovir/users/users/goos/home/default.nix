{ config, pkgs, lib, szy, osConfig, ... }:
{

	imports = [
		./desktops
		./programs

		./shells/Tilia-dev
	];	
	
	home.stateVersion = "26.05";

}
