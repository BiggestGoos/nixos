{ pkgs, lib, config, ... }:
let

	lockOuterWall = pkgs.writeShellScriptBin "lockOuterWall" ''
		${lib.meta.getExe' pkgs.coreutils "touch"} ${config.outerWall.lock.lockfile}
		${lib.meta.getExe' pkgs.procps "pkill"} -t tty${builtins.toString config.outerWall.lock.tty}
		${lib.meta.getExe' pkgs.busybox "chvt"} ${builtins.toString config.outerWall.lock.tty}
		${lib.meta.getExe pkgs.physlock} -l
	'';

	unlockOuterWall = pkgs.writeShellScriptBin "unlockOuterWall" ''
		${lib.meta.getExe' pkgs.coreutils "rm"} ${config.outerWall.lock.lockfile}
		${lib.meta.getExe pkgs.physlock} -L
	'';

in
{

	environment.systemPackages =
	[
		lockOuterWall
		unlockOuterWall
	];

}
