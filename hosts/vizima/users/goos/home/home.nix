{ config, pkgs, ... }:
let
	username = "goos";
in
{

	home.username = username;
	home.homeDirectory = "/home/${username}";
	
	imports = [
		./desktops
		./programs
	];

	programs.git = {
		enable = true;
		userName = "BiggestGoos";
		userEmail = "gustav@fagerlind.net";
	};

	home.packages = [
		pkgs.tree
	];

	home.stateVersion = "25.11";
}
