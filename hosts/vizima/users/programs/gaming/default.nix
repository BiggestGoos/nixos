{ ... }:
{

	imports = [
		./steam
		./gamemode.nix
		./gamescope.nix
	];

	boot.kernel.sysctl."vm.max_map_count" = 2147483642;

}
