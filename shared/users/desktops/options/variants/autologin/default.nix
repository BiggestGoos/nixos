variant:
{ lib, szy, config, ... }:
{

	options."${szy}".desktops.options.autologin = {

		user = lib.mkOption {
			type = lib.types.enum config."${szy}".users.available;
			default = config."${szy}".users.default;
		};

		enabled = lib.mkOption {
			type = lib.types.bool;
			readOnly = true;
		};

	};

	config."${szy}".desktops.options.autologin.enabled = (lib.mkForce variant.enabled);

}
