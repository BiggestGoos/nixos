{ szy, lib, config, ... }:
let

	cfg = config."${szy}".timeZone;

in
{

	options."${szy}".timeZone = {

		default = lib.mkOption {
			type = lib.types.str;
		};

		automatic = lib.mkOption {
			type = lib.types.bool;
			default = false;
		};

	};

	config = {

		services.automatic-timezoned.enable = cfg.automatic;

		time.timeZone = lib.mkDefault cfg.default;

	};

}
