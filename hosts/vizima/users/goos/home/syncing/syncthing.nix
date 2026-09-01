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
				kovir.id = config."${szy}".secrets.public.syncthing.kovir.goos;
				novigrad.id = config."${szy}".secrets.public.syncthing.novigrad.goos;
			};

			folders =
			{
				
				Documents =
				{
					devices =
					[
						"mahakam"
						"kovir"
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
						"kovir"
					];
					id = "personal";
					path = "~/Personal";
				};

				Media =
				{
					devices =
					[
						"mahakam"
						"kovir"
						"novigrad"
					];
					id = "media";
					path = "~/Media";
				};

			};

		};

	};

}
