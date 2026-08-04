{
	disko.devices.disk.cidaris = 
	{
		type = "disk";
		device = "/dev/disk/by-id/ata-ST2000DM008-2UB102_ZFL8ZMJK";
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
}
