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
	{ final, template }:
	{

		package = config.programs.floorp.finalPackage;

		program.arguments.search.args = [ "--search" ];

	};

	configuration =
	{ enabled, final, template }:
	{

		programs.floorp = {

			enable = true;

			profiles."${config.home.username}" = {

				id = 0;
				isDefault = true;

			};

		};

	};

}
