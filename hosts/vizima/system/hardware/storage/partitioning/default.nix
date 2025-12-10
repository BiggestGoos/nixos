{ ... }:
{

	fileSystems."/" =
    { 
		device = "/dev/disk/by-label/vizima-base";
    	fsType = "btrfs";
    	options = [ "subvol=root" "compress=zstd" "x-systemd.device-timeout=0" ];
    };

	fileSystems."/home" =
    { 
		device = "/dev/disk/by-label/vizima-base";
      	fsType = "btrfs";
      	options = [ "subvol=home" "compress=zstd" ];
    };

  	fileSystems."/nix" =
    { 
		device = "/dev/disk/by-label/vizima-base";
      	fsType = "btrfs";
      	options = [ "subvol=nix" "compress=zstd" ];
    };

	fileSystems."/boot" =
    { 
		device = "/dev/disk/by-label/vizima-boot";
      	fsType = "vfat";
      	options = [ "fmask=0022" "dmask=0022" ];
    };

	swapDevices = [ { device = "/dev/disk/by-label/vizima-swap"; } ];

	boot.initrd.luks.devices."vizima-unencrypted-root" = {
		device = "/dev/disk/by-label/vizima-encrypted-root";
		allowDiscards = true;
	};

}
