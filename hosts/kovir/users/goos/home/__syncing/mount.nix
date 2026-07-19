{ szy, config, lib, ... }:
(szy config).objects.define
{

	template = "remoteMountPersistent";
	name = "deviceSync";

	enable = true;

	arguments =
	{

		remote =
		{
			name = "onedrive";
			template = "remote";
		};

		remotePath = "Sync";

		mountPoint = "${config.home.homeDirectory}/mnt";

	};

}
