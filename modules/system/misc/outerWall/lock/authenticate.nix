{ pkgs, lib, config, ... }:
let

	lock = pkgs.callPackage ./internal/outerWallLock {};

in
{

	# https://github.com/NixOS/nixpkgs/blob/37dc568acd913fb18235ba71bad8236648effe08/nixos/modules/security/pam.nix#L116-L117
	security.pam.globalRules.auth.outerWallLock = lib.mkIf (config.outerWall.enable)
	{
		enable = true;
		order = 100;
		control = "requisite";
		modulePath = "${lock}/lib/security/pam_outer_wall_lock.so";

		settings =
		{
			user = config.outerWall.username;
			lock = config.outerWall.lock.lockfile;
		};
    };

}
