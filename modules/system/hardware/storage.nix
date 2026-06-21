{ szy, lib, config, ... }:
let

	cfg = config."${szy}".storage;

in
{

	options."${szy}".storage = {

		ssd.trim = {
			
			enable = lib.mkOption {
				type = lib.types.bool;
				default = true;
			};

			interval = lib.mkOption {
				type = lib.types.str;
				default = "weekly";
			};

		};

	};

	config.services.fstrim = cfg.ssd.trim;

}
