{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [ 
	(modulesPath + "/installer/scan/not-detected.nix")
	./graphics.nix
	./networking.nix
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" "cryptd"];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-label/vizima-base";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" "x-systemd.device-timeout=0" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-label/vizima-base";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-label/vizima-base";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/vizima-boot";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ { device = "/dev/disk/by-label/vizima-swap"; } ];

  boot.initrd.luks.devices."vizima-unencrypted-root" = {

  	device = "/dev/disk/by-label/vizima-encrypted-root";
	
	allowDiscards = true;

  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
