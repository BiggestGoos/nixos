{ szy, lib, config, pkgs, ... }:
(szy config).users.user.create config.sync.user true
{
	
	enable = config.sync.enable;

	arguments =
	{ final, ... }:
	{

		modules = 
		[
			{

				home.stateVersion = "26.05";

			}
		];
	
		primaryGroup = final.data.username;

		types = [ "system" ];

		settings =
		{

			createHome = true;
			homeMode = "770";

			linger = true;

		};

	};

	options =
	{

		sync =
		{

			enable = lib.options.mkOption
			{
				type = lib.types.bool;
				default = true;
			};

			user = lib.options.mkOption
			{
				type = lib.types.str;
				default = "sync";
			};

			baseDirectory = lib.options.mkOption
			{
				type = lib.types.str;
				default = "/storage";
			};

			remoteDirectory = lib.options.mkOption
			{
				type = lib.types.str;
				default = "remote:Sync";
			};

		};

	};

}
