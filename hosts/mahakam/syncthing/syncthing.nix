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
					type = "receiveencrypted";
				};

				Media =
				{
					devices =
					[
						"kovir"
					];
					id = "media";
					path = "~/Media";
				};

				# TODO: Make a new Media folder that ignores Camera folder such that we don't need to add new media subfolders

				Media_Camera =
				{
					devices =
					[
						"novigrad"
					];
					id = "media_camera";
					path = "~/Media/Camera";
				};

				Media_Downloads =
				{
					devices =
					[
						"novigrad"
					];
					id = "media_downloads";
					path = "~/Media/Downloads";
				};

			};

		};

	};

}
