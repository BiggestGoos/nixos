{ config, ... }:
{

	sops.secrets.rclone-onedrive =
	{
		sopsFile = ./rclone-onedrive.secret.yaml;
	};

	programs.rclone.remotes.onedrive =
	{

		config = 
		{

			type = "onedrive";	

			drive_type = "personal";
			drive_id = "AFEAEC28925FF1B6";

		};

		secrets =
		{

			token = config.sops.secrets.rclone-onedrive.path;

		};

	};

	syncing.baseRemote = "onedrive";

}
