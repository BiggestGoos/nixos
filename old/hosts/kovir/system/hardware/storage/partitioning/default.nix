let
	compress = "compress-force=zstd:15";
in
{
	disko.devices = {
		disk = {
			main = {
				type = "disk";
				device = "/dev/disk/by-id/ata-Samsung_SSD_870_EVO_1TB_S75CNX0WC60272M";
				content = {
					type = "gpt";
					partitions = {
						ESP = {
							size = "1G";
							type = "EF00";
							content = {
								type = "filesystem";
								format = "vfat";
								mountpoint = "/boot";
								mountOptions = [ "defaults" ];
							};
						};
						base = {
							size = "100%";
							content = {
								type = "btrfs";
								extraArgs = [ "-f" ]; # Not sure but the example uses it.
					
								mountpoint = "/partitions";

								subvolumes = {

									"@root" = {
										mountpoint = "/";
										mountOptions = [ "defaults" compress ];
									};

									"@home" = {
										mountpoint = "/home";
										mountOptions = [ "defaults" compress ];
									};

									"@nix" = {
										mountpoint = "/nix";
										mountOptions = [ "defaults" compress "noatime" ];
									};

								};
							};
						};
					};
				};
			};
		};
	};
}
