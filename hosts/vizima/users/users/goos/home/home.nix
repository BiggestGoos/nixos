{ config, pkgs, lib, szy, osConfig, ... }:
let
	username = "goos";
in
{

	home.username = username;
	home.homeDirectory = "/home/${config.home.username}";
	
	imports = [
		./desktops
		./programs
		(szy.utils.fromRoot "szy/themes")
	];	

	specialisation.test3.configuration = {

		home.packages = [
			pkgs.onefetch
		];

	};

	home.stateVersion = "25.11";
}
