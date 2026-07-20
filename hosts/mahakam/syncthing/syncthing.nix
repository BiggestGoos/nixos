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

				kovir =
				{
					id = config."${szy}".secrets.public.syncthing.kovir.goos;
				};

			};

			folders =
			{
				test =
				{
					devices =
					[
						"kovir"
					];
					id = "test";
					path = "~/Test";
				};

			};

		};

	};

}
