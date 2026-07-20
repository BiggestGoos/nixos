{ szy, config, ... }:
{

	services.syncthing =
	{

		enable = true;

		settings =
		{

			devices.mahakam.id = config."${szy}".secrets.public.syncthing.mahakam.system;

			folders.test =
			{
				devices =
				[
					"mahakam"
				];
				id = "test";
				path = "~/Test";
			};

		};

	};

}
