{ szy, config, lib, ... }:
(szy config).objects.define
{

	template = "remote";
	name = "onedrive";

	enable = true;

	arguments.settings =
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

	configuration =
	{

		sops.secrets.rclone-onedrive =
		{
			sopsFile = ./rclone-onedrive.secret.yaml;
		};

	};

}
