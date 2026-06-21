{ config, pkgs, lib, szy, osConfig, ... }:
{

	imports = [
		./desktops
		./programs
	#	./sync

	#	./shells/Tilia-dev

	#	./steamTest.nix
	];	
	
	home.stateVersion = "26.05";

}
