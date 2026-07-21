{ szy, config, ... }:
{

	services.syncthing =
	{

		enable = true;

		settings =
		{

			devices.mahakam.id = config."${szy}".secrets.public.syncthing.mahakam.system;

			folders =
			let
				devices = [ "mahakam" ];
			in
			{

			};

		};

	};

}
