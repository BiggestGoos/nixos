{ config, ... }:
{

	sops.secrets."rclone/onedrive" =
	{
		sopsFile = ./onedrive.secret.yaml;
		
		owner = config.sync.user;
		group = config.users.users."${config.sync.user}".group;
	};

}
