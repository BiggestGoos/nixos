{ config, ... }:
let

  inherit (config.services.syncthing) dataDir;

in
{
	disko.devices.disk.main.content.partitions.storage.content =
	{
		mountpoint = dataDir;
		mountOptions =
		[
			"defaults"
			"nofail"
		];
	};

	systemd.tmpfiles.settings."syncthing-home" = 
	{
		"${dataDir}"."z" = 
		let
			user = config.services.syncthing.user;
		in
		{
			inherit user;
			group = config.users.users."${user}".group;
		};
	};

}
