{ config, ... }:
let

	directory = config.snapshots.baseDirectory;

in
{
	disko.devices.disk.storage.content.partitions.root.content.subvolumes."@snapshots" =
	{
		mountpoint = directory;
		mountOptions =
		[
			"defaults"
			"nofail"
			"compress=zstd"
		];
	};

	systemd.tmpfiles.settings."sync-snapshots" = 
	{
		"${directory}"."z" = 
		let
			user = config.sync.user;
		in
		{
			inherit user;
			group = config.users.users."${user}".group;
			mode = "0770";
		};
	};

}
