{ szy, pkgs, lib, config, ... }:
let

	cfg = config."${szy}".boot;

in
{

	options."${szy}".boot = {

		silent.enable = lib.mkOption {
			type = lib.types.bool;
			default = true;
		};

		timeout.enable = lib.mkOption {
			type = lib.types.bool;
			default = true;
		};

	};

  	config.boot = szy.utils.mergeAll [ {

		initrd.systemd.services = lib.mkIf (cfg.timeout.enable) {

			boot-timeout = {
				wantedBy = [ "initrd.target" ];
				before = [ "cryptsetup.target" ];
		
				# In seconds, 300 = 5 Minutes
				script = "(sleep 300 && shutdown now) & disown";

				unitConfig.DefaultDependencies = "no";
				serviceConfig.Type = "forking";
			};
		};

	} 
	(
	lib.mkIf (cfg.silent.enable)
	{ 

		loader.timeout = 0;

   		consoleLogLevel = 3;

   		initrd = {
			verbose = false;
   			systemd.enable = true;
		};

   		kernelParams = [
       		"quiet"
       		"splash"
       		"intremap=on"
       		"rd.udev.log_priority=3"
       		"rd.systemd.show_status=auto"
   		];

	}) ];

}
