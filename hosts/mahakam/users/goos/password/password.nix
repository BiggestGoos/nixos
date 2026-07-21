{

	sops.secrets."users/goos/password" =
	{
		sopsFile = ./password.secret.yaml;
		neededForUsers = true;
	};

}
