{ lib, config, szy, ... }:
{

	options.syncing =
	{

		baseRemote = lib.options.mkOption
		{
			type = lib.types.enum (builtins.attrNames config.programs.rclone.remotes);
		};

	};

	config =
	{

		programs.rclone =
		{

			enable = true;

			remotes.onedrive.mounts.base =
			{
				enable = true;
				mountPoint = "${config.home.homeDirectory}/mnt";
			};

		};

	};

}
