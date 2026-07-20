{ config, ... }:
{

	sops.secrets."ssh/private" =
	{
		sopsFile = ./key.secret.yaml;
		mode = "0600";
	};

	programs.ssh.settings."*".IdentityFile = config.sops.secrets."ssh/private".path;

}
