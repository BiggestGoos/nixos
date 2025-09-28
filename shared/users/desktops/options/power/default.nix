{ lib, config, szy, ... }:
{

	options."${szy}".desktops.options.power = {

		hibernateDelay = lib.mkOption {
			type = lib.types.str;
			default = "15min";
		};

	};

	config = 
	{

		systemd.sleep.extraConfig = "HibernateDelaySec=${config."${szy}".desktops.options.power.hibernateDelay}";

	};

}
