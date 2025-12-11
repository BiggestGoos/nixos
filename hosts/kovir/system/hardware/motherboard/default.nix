{ ... }:
{

	# https://github.com/NixOS/nixos-hardware/blob/master/gigabyte/b650/b650-fix-suspend.nix
	boot.kernelParams = [
		"acpi_osi=\"!Windows 2015\""
	];

}
