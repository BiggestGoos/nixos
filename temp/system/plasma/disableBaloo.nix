{ pkgs, ... }:
{

	environment.plasma6.excludePackages =
	[
		pkgs.kdePackages.baloo
	];

}
