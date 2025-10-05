{ ... }:
{

	imports = [
		./style.nix
		./input.nix
		./misc.nix
	];

	wayland.windowManager.hyprland = {

		enable = true;
		systemd.enable = false;

	};

}
