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

	specialisation.test3.configuration = {

		home.packages = [
			pkgs.onefetch
		];

	};

	home.stateVersion = "25.11";
}
