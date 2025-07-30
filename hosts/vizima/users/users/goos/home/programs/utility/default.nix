{ pkgs, ... }:
{

	imports = [
		./bitwarden.nix
		./nh.nix
	];

	home.packages = with pkgs; [
		tree
		wget
	];

}
