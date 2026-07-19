{ config, lib, ... }:
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
					id = "DF6ZAIJ-5P63WJR-QDVFXU7-WLJL3IY-E4HLXKV-244HJOV-PODKGDN-6WVQNQN";
				};

				novigrad =
				{
					id = "DZLTEPC-V5XO3FT-OHF7BI4-YKGLOUR-SMNHBZT-5RMBGSR-BOGLC3N-Q6HPZAS";
				};

			};

			folders =
			{
				Test =
				{
					devices =
					[
						"kovir"
						"novigrad"
					];
					id = "yqqvb-2vuce";
					path = "~/Test";
				};

			};

		};

	};

}
