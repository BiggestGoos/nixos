{ lib }:
rec {

	available = config: config.desktops.available;

	default = config: config.desktops.default;
	enabled = config: config.desktops.enabled;

	isValid = config: name: (builtins.elem name (available config));
	assertValid = config: name: assert (isValid config name); name;

	isEnabled = config: name: if (enabled config == null) then false else (builtins.elem (assertValid config name) enabled config);
	isDefault = config: name: if (default config == null) then false else ((assertValid config name) == default config);

	ifEnabled = config: name: configuration: (lib.mkIf (isEnabled config name) configuration);
	ifDefault = config: name: configuration: (lib.mkIf (isDefault config name) configuration);
/*
	bake = config: rec {

		available = available config;

		default = default config;
		enabled = enabled config;

		isValid = isValid config;
		assertValid = assertValid config;
		
		isEnabled = isEnabled config;
		isDefault = isDefault config;

		ifEnabled = ifEnabled config;
		ifDefault = ifDefault config;

	};
*/
}
