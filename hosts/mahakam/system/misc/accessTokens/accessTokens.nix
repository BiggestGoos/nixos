{ config, ... }:
{

	nix.extraOptions =
	''
		!include ${config.sops.secrets.accessTokens.github}
	'';

	sops.secrets."accessTokens/github" =
	{
		sopsFile = ./github.secret.yaml;
		mode = "0440";
		group = config.users.groups."nixmgr".name;
	};

}
