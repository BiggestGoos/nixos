{ config, lib, pkgs, ... }:
{

	config = lib.mkIf (config.outerWall.enable)
	{

		environment.systemPackages =
		[
			pkgs.gocryptfs
		];

	};

}
