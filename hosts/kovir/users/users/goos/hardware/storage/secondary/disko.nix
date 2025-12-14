{ root ? "" }:
{
	disko.devices = {
		disk = {
			secondary = {
				type = "disk";
				device = "/dev/disk/by-id/ata-PNY_2TB_SATA_SSD_PNA4025503117AT00332";
				content = {
					type = "gpt";
					partitions = {
						base = {
							size = "100%";
							content = {
								type = "btrfs";
								extraArgs = [ "-f" ]; # Not sure but the example uses it.

								mountpoint = "${root}/partitions";

								subvolumes = import ./subvolumes.nix root;
							};
						};
					};
				};
			};
		};
	};
}
