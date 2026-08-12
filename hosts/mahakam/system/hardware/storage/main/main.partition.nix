{
	disko.devices.disk =
	{
		main = 
		{
			type = "disk";
			device = "/dev/disk/by-id/ata-SAMSUNG_SSD_830_Series_S0XYNEAC651226";
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
		storage =
		{
			type = "disk";
			device = "/dev/disk/by-id/ata-TOSHIBA_HDWD130_Z7U7BDRAS";
			content = 
			{
				type = "gpt";
				partitions = 
				{
					root =
					{
						size = "100%";
						content =
						{
							type = "btrfs";
							subvolumes."@root" = { };
						};
					};
				};
			};
		};
	};
}
