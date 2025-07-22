{ config, lib, pkgs, fetchurl, ... }:
{

	nixpkgs.config.packageOverrides = pkgs:
	{
		
		plymouth = (pkgs.plymouth.overrideAttrs (oldAttrs: {
#      			name = "plymouth-test";
			#src = /home/goos/Dev/plymouth;
			src = builtins.fetchurl {
				url = "https://github.com/BiggestGoos/plymouth-fork/archive/refs/tags/release3.tar.gz";
				sha256 = "0fimhs4vlb7mvj837f7nqlijbpx73mvi55wiavv2ri3qff7qqgcq";
			};
    		}));

	};

boot = {

    # silence first boot output
    consoleLogLevel = 3;
    initrd.verbose = false;
    initrd.systemd.enable = true;
    kernelParams = [
        "quiet"
        "splash"
        "intremap=on"
        "rd.udev.log_priority=3"
        "rd.systemd.show_status=auto"
	"plymouth.use_simpledrm"
    ];

    # plymouth, showing after LUKS unlock
    plymouth.enable = true;
    plymouth.font = "${pkgs.hack-font}/share/fonts/truetype/Hack-Regular.ttf";
    plymouth.logo = "${pkgs.nixos-icons}/share/icons/hicolor/128x128/apps/nix-snowflake.png";

    plymouth.extraConfig = "ShowDelay=2\nUseFirmwareBackground=false";
};

	boot.loader.timeout = 0;

	boot.initrd.systemd.services.boot-timeout = {
		wantedBy = [ "initrd.target" ];
		before = [ "cryptsetup.target" ];
		
		# In seconds, 300 = 5 Minutes
		script = "(sleep 300 && shutdown now) & disown";

		unitConfig.DefaultDependencies = "no";
		serviceConfig.Type = "forking";
	};

}
