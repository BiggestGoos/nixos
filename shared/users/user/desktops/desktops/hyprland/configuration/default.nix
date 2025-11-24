{ ... }:
{

	imports = [
		./style.nix
		./binds.nix
		./misc.nix
		./devices.nix
		./displays.nix
	];

	wayland.windowManager.hyprland = {

		enable = true;
		systemd.enable = false;

	};

}
