{ config, lib, ... }:
{

	sops.secrets =
	let
		secretValue =
		let
			inherit (config.services.syncthing) user;
		in
		{
			sopsFile = ./id.secret.yaml;
			owner = user;
			inherit (config.users.users."${user}") group;
		};
	in
	{
		"syncthing/cert.pem" = secretValue;
		"syncthing/key.pem" = secretValue;
	};

	services.syncthing =
	{
		cert = config.sops.secrets."syncthing/cert.pem".path;
		key = config.sops.secrets."syncthing/key.pem".path;
	};

}
