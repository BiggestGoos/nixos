{ config, lib }:
rec {

	available = [ "hyprland" "gnome" "plasma" ];

	isValid = name: (builtins.elem name available);
	assertValid = name: assert (isValid name); name;

	isEnabled = name: (builtins.elem (assertValid name) config.desktops.enabled);
	isDefault = name: ((assertValid name) == config.desktops.default);

	ifEnabled = name: configuration: (lib.mkIf (isEnabled name) configuration);
	ifDefault = name: configuration: (lib.mkIf (isDefault name) configuration);

}
