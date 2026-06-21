{ pkgs, desktop, lib, ... }:
{

	home.packages = with pkgs; lib.lists.optionals (desktop.isEnabledStrict [ "hyprland" ]) [
		blueman
		pavucontrol
	];

	imports = [
		./batsignal.nix
		./hypridle.nix
		./hyprlock.nix
		./rofi.nix
		./swaync.nix
		./playerctl.nix
		./brillo.nix
	];

}
