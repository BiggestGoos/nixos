{
	disko.devices.disk.main = 
	{
		type = "disk";
		device = "/dev/disk/by-id/ata-TOSHIBA_HDWD130_Z7U7BDRAS";
		content = 
		{
			type = "gpt";
			partitions = 
			{
				boot = 
				{
					size = "2G";
					type = "EF00";
					content = 
					{
						type = "filesystem";
						format = "vfat";
					};
				};
				root = 
				{
					size = "100G";
					content = 
					{
						type = "filesystem";
						format = "ext4";
					};
				};
				storage =
				{
					size = "100%";
					content =
					{
						type = "filesystem";
						format = "ext4";
					};
				};
			};
		};
	};
}
