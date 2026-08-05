{ config, lib, ... }:
{

	sops.secrets =
	let
		sopsFile = ./id.secret.yaml;
	in
	{
		"syncthing/cert.pem" = { inherit sopsFile; };
		"syncthing/key.pem" = { inherit sopsFile; };
	};

	services.syncthing =
	{
		cert = config.sops.secrets."syncthing/cert.pem".path;
		key = config.sops.secrets."syncthing/key.pem".path;
	};

}
