{ config, ... }:
let

	directory = config.sync.baseDirectory;

in
{
	disko.devices.disk.storage.content.partitions.root.content.subvolumes."@root" =
	{
		mountpoint = directory;
		mountOptions =
		[
			"defaults"
			"nofail"
			"compress=zstd"
		];
	};

	systemd.services.syncthing.unitConfig.RequiresMountsFor = 
	[
		directory
	];

	systemd.tmpfiles.settings."sync-storage" = 
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
