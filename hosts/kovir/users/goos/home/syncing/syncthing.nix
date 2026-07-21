{ szy, config, ... }:
{

	services.syncthing =
	{

		enable = true;

		settings =
		{

			devices.mahakam.id = config."${szy}".secrets.public.syncthing.mahakam.system;

			folders =
			{
				
				Documents =
				{
					devices =
					[
						"mahakam"
					];
					id = "documents";
					path = "~/Documents";
				};

				Personal =
				{
					devices =
					[
						{
							name = "mahakam";
							encryptionPasswordFile = config.sops.secrets."syncthing/encryption_password".path;
						}
					];
					id = "personal";
					path = "~/Personal";
				};

				Media =
				{
					devices =
					[
						"mahakam"
					];
					id = "media";
					path = "~/Media";
				};

			};

		};

	};

}
