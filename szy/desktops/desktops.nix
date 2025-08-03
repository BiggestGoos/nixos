{ config, lib }:
rec {

	available = config.desktops.available;

	default = config.desktops.default;
	enabled = config.desktops.enabled;

	isValid = name: (builtins.elem name available);
	assertValid = name: assert (isValid name); name;

	isEnabled = name: if (enabled == null) then false else (builtins.elem (assertValid name) enabled);
	isDefault = name: if (default == null) then false else ((assertValid name) == default);

	ifEnabled = name: configuration: (lib.mkIf (isEnabled name) configuration);
	ifDefault = name: configuration: (lib.mkIf (isDefault name) configuration);

}
