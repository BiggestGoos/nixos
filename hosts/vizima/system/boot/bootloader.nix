{ pkgs, fetchurl, ... }:
{

  	boot = {

		loader = { 
			systemd-boot = {
				enable = true; 				
				configurationLimit = 10;
			};

			efi.canTouchEfiVariables = true;
			
			timeout = 0;
		};

  		# Use latest kernel.
  		kernelPackages = pkgs.linuxPackages_latest;

	
		initrd.systemd.services.boot-timeout = {
			wantedBy = [ "initrd.target" ];
			before = [ "cryptsetup.target" ];
		
			# In seconds, 300 = 5 Minutes
			script = "(sleep 300 && shutdown now) & disown";

			unitConfig.DefaultDependencies = "no";
			serviceConfig.Type = "forking";
		};

	};

}
