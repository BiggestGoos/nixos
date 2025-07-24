{ pkgs, ... }:
{

	imports = [
		./batsignal.nix
	];

	home.packages = with pkgs; [
		blueman
		pavucontrol
	];

}
