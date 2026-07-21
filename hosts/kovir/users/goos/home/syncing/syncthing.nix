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
