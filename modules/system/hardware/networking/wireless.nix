{
	
	networking =
	{
		wireless = 
		{
			enable = false;

			iwd = 
			{

				enable = true;

				settings = 
				{
		
					General.AddressRandomization = "network";
					Settings.AutoConnect = true;

				};

			};

		};

		networkmanager.wifi = 
		{
			backend = "iwd";
			powersave = true;
		};

	};

}
