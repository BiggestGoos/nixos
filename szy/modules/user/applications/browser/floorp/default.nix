{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;

	name = "floorp";
	template = "browser";

	extends = [ ];

	arguments =
	{ final, object, ... }:
	{

		application = {
			type = "gui";
		};

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

		imports = enabled
		[
			./default
		];

	};

}
