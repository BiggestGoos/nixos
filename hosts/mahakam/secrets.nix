{ config, ... }:
let
	path = "/var/lib/sops-nix/key.txt";
in
{

	sops =
	{
		age.keyFile = path;
	};

	environment.sessionVariables =
	{
		SOPS_AGE_KEY_FILE = path;
	};

}
