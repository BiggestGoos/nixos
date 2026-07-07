{ szy, config, pkgs, ... }:
(szy config).users.user.create config.outerWall.username false
{

	enable = config.outerWall.enable;

	arguments =
	{

		types = [ "system" ];
		shell = pkgs.bash;

		primaryGroup = config.outerWall.username;
		extraGroups = [ "wheel" ];

		settings =
		{

			createHome = true;
			homeMode = "711";

		};

	};

}
