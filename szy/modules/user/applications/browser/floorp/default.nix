{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;

	name = "floorp";
	template = "browser";

	qualifiers =
	{

		_meta.order = [ "composable" ];

		composable =
		{

			components = 
			{
				default =
				{
					path = "default";
					enable = true;
				};
			};

			componentPath = ./.;

		};

	};

	arguments =
	{ final, object, ... }:
	{

		package = config.programs.floorp.package;

		commands.search = "${final.data.commands.exec} --search";

	};

	configuration =
	enabled:
	{ final, object, ... }:
	{

		programs.floorp = enabled {

			enable = true;

			profiles."${config.home.username}" = {

				id = 0;
				isDefault = true;

			};

		};

	};

}
