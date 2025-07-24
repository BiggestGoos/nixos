{ pkgs, ... }:
{

	imports = [
		./bitwarden.nix
	];

	home.packages = with pkgs; [
		blueman
		pavucontrol

		tree
		wget
	];

}
