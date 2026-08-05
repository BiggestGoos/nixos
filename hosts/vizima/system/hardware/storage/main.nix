let
	compress = "compress=zstd";
in
{
	disko.devices = 
	{
		disk.main = 
		{
			type = "disk";
			device = "/dev/disk/by-id/nvme-SK_hynix_BC711_HFM256GD3JX013N_FYB2N026213102E0T";
			content = {
				type = "gpt";
				partitions = 
				{
					ESP = 
					{
						size = "1G";
						type = "EF00";
						content = 
						{
							type = "filesystem";
							format = "vfat";
							mountpoint = "/boot";
							mountOptions = [ "defaults" ];
						};
					};
					base =
					{
						size = "100%";
						content =
						{
							type = "luks";
							name = "encrypted";
							passwordFile = "/tmp/password.key";
							settings.allowDiscards = true;
							content =
							{
								type = "lvm_pv";
								vg = "base";
							};
						};
					};
				};
			};
		};
		lvm_vg."base" =
		{
			type = "lvm_vg";
			lvs =
			{
				swap =
				{
					size = "16G";
					content =
					{
						type = "swap";
						resumeDevice = true;
					};
				};
				root =
				{
					size = "100%";
					content =
					{

						type = "btrfs";
			
						mountpoint = "/partitions";

						subvolumes = 
						{

							"@root" = 
							{
								mountpoint = "/";
								mountOptions = [ "defaults" compress ];
							};

							"@home" = 
							{
								mountpoint = "/home";
								mountOptions = [ "defaults" compress ];
							};

							"@nix" = 
							{
								mountpoint = "/nix";
								mountOptions = [ "defaults" compress "noatime" ];
							};

						};

					};
				};
			};
		};
	};
}
