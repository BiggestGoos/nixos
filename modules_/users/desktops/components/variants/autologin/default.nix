variant:
{ lib, szy, config, ... }:
{

	options."${szy}".desktops.components.autologin = {

		user = lib.mkOption {
			type = lib.types.enum config."${szy}".users.available;
			default = config."${szy}".users.default.name;
		};

		enabled = lib.mkOption {
			type = lib.types.bool;
			readOnly = true;
		};

	};

	config."${szy}".desktops.components.autologin.enabled = (lib.mkForce variant.enabled);

}
