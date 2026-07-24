{ szy, config, lib, ... }:
let

	unrestricted = config.sync.baseDirectory + "/Unrestricted";
	restricted = config.sync.baseDirectory + "/Restricted";

	inherit (config.sync) user;
	inherit (config.users.users."${user}") group;

in
{

	systemd.tmpfiles.settings."syncthing-directories" =
	let
		own = 
		{
			inherit user group;
			mode = "0770";
		};
		value =
		{
			"d" = own;
			"z" = own;
		};
	in
	{
		"${unrestricted}" = value;
		"${restricted}" = value;
	};

	services.syncthing =
	{

		enable = true;
		openDefaultPorts = true;

		inherit user group;
		
		dataDir = config.users.users."${user}".home;

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
					path = "${unrestricted}/Documents";
				};

				Personal =
				{
					devices =
					[
						"kovir"
					];
					id = "personal";
					path = "${restricted}/Personal";
				};

				Media =
				{
					devices =
					[
						"kovir"
						"novigrad"
					];
					id = "media";
					path = "${unrestricted}/Media";
				};

				# Only the camera part of media
				Media_Camera =
				{
					devices =
					[
						"novigrad"
					];
					id = "media_camera";
					path = "${unrestricted}/Media/Camera";
				};

			};

		};

	};

}
