{ pkgs, lib, config, ... }:
let

	storageDirectory = config.sync.baseDirectory;
	snapshotDirectory = config.snapshots.baseDirectory;

	package = pkgs.writeShellScriptBin "makeSnapshot"
''
timestamp="$(${lib.meta.getExe' pkgs.coreutils "date"} +%s)"
${lib.meta.getExe' pkgs.btrfs-progs "btrfs"} subvolume snapshot -r ${storageDirectory} ${snapshotDirectory}/$timestamp
'';

in
{

	environment.systemPackages =
	[
		package
	];

}
