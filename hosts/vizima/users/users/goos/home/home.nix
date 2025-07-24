{ config, pkgs, lib, ... }:
let
	username = "goos";
in
{

	home.username = username;
	home.homeDirectory = "/home/${config.home.username}";
	
	imports = [
		./desktops
		./programs
	];	

	home.stateVersion = "25.11";
}
