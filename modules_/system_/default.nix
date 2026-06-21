{ lib, pkgs, ... }:
{

	imports = [
		./misc
		./hardware
	];

	boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

}
