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

				Personal =
				{
					devices =
					[
						"kovir"
					];
					id = "personal";
					path = "~/Personal";
				};

				Media =
				{
					devices =
					[
						"kovir"
						"novigrad"
					];
					id = "media";
					path = "~/Media";
				};

				# Only the camera part of media
				Media_Camera =
				{
					devices =
					[
						"novigrad"
					];
					id = "media_camera";
					path = "~/Media/Camera";
				};

			};

		};

	};

}
