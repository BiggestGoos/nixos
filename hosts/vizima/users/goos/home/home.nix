{ config, pkgs, ... }:
{

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
