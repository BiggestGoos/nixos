{ pkgs, ... }:
{

	imports = [
		./bitwarden.nix
	];

	home.packages = with pkgs; [
		tree
		wget
	];

}
