{
	
	networking =
	{
		wireless = 
		{
			enable = true;

			/*iwd = 
			{

				enable = true;

				settings = 
				{
		
					General.AddressRandomization = "network";
					Settings.AutoConnect = true;

				};

			};*/

		};

		networkmanager.wifi = 
		{
			#backend = "iwd";
			powersave = true;
		};

	};

}
