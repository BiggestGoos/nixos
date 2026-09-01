{ szy, config, ... }:
{

	services.syncthing =
	{

		enable = true;

		settings =
		{

			devices =
			{
				mahakam.id = config."${szy}".secrets.public.syncthing.mahakam.system;
				vizima.id = config."${szy}".secrets.public.syncthing.vizima.goos;
				novigrad.id = config."${szy}".secrets.public.syncthing.novigrad.goos;
			};

			folders =
			{
				
				Documents =
				{
					devices =
					[
						"mahakam"
						"vizima"
						"novigrad"
					];
					id = "documents";
					path = "~/Documents";
				};

				Personal =
				{
					devices =
					[
						"mahakam"
						"vizima"
					];
					id = "personal";
					path = "~/Personal";
				};

				Media =
				{
					devices =
					[
						"mahakam"
						"vizima"
						"novigrad"
					];
					id = "media";
					path = "~/Media";
				};

				Games_Emulation_GBA =
				{
					devices =
					[
						"mahakam"
					];
					id = "games_emulation_gba";
					path = "~/Games/Emulation/GBA";
				};

			};

		};

	};

}
