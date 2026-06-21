{ pkgs, szy, ... }:
{

	home.packages = with pkgs; [
		blueman
		pavucontrol
	];

}
