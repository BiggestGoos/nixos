{ szy, lib, config, pkgs, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "composable";
	enable = true;

	parameters =
	{ final, object }:
	{

		components = lib.options.mkOption
		{
			type = lib.types.attrsOf (lib.types.submoduleWith { modules = 
			[ {

				options = 
				{
			
					path = lib.options.mkOption
					{
						type = lib.types.path;
					};

					enable = lib.options.mkOption
					{ 
						type = lib.types.bool;
					};

				};

			} ]; });
		};

	};

}
