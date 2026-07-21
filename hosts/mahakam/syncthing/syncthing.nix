{ szy, config, lib, ... }:
{


	services.syncthing =
	{

		enable = true;
		openDefaultPorts = true;

		settings =
		{
		 
			devices =
			{

				kovir.id = config."${szy}".secrets.public.syncthing.kovir.goos;
				novigrad.id = config."${szy}".secrets.public.syncthing.novigrad.goos;

			};

			folders =
			{

				Documents =
				{
					devices =
					[
						"kovir"
						"novigrad"
					];
					id = "documents";
					path = "~/Documents";
				};

			};

		};

	};

}
