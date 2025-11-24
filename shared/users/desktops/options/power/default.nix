{ lib, config, szy, ... }:
{

	options."${szy}".desktops.options.power = {

		hibernate.delay = lib.mkOption {
			type = lib.types.str;
			default = "15min";
		};

		lidSwitch = {
			default = lib.mkOption {
				type = lib.types.str;
				default = "suspend-then-hibernate";
			};
			externalPower = lib.mkOption {
				type = lib.types.str;
				default = "suspend-then-hibernate";
			};
			docked = lib.mkOption {
				type = lib.types.str;
				default = "suspend-then-hibernate";
			};
		};

	};

	config = 
	{

		systemd.sleep.extraConfig = "HibernateDelaySec=${config."${szy}".desktops.options.power.hibernate.delay}";

		services.logind.settings.Login = { 
			HandleLidSwitch = config."${szy}".desktops.options.power.lidSwitch.default;
			HandleLidSwitchExternalPower = config."${szy}".desktops.options.power.lidSwitch.externalPower;
			HandleLidSwitchDocked = config."${szy}".desktops.options.power.lidSwitch.docked;
		};

	};

}
