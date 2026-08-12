{ config, ... }:
{

	programs.ssh =
	{
		enable = true;
		enableDefaultConfig = false;
		settings =
		{

			"mahakam" =
			{
				HostName = "mahakam";
				User = "goos";
			};

		};
	};

}
