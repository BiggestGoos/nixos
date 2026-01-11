{ szy, pkgs, ... }:
{

	imports = [  
		./users
		./system

		#./steamTest.nix
	];

	services.sunshine = {

		enable = true;
		capSysAdmin = true;
		openFirewall = true;

	};

    networking.extraHosts = ''
      0.0.0.0 log-upload-os.hoyoverse.com
	  0.0.0.0 overseauspider.yuanshen.com
	  0.0.0.0 apm-log-upload-os.hoyoverse.com
	  0.0.0.0 zzz-log-upload-os.hoyoverse.com
    '';

	system.stateVersion = "26.05"; 

}

