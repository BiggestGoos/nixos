{ szy, config, lib, pkgs, ... }:
{
	
	imports = [

	(szy.objects.declare
	{
	
		callerData = {
			inherit config;
		};

		name = "thing";

		parameters = 
		{ final }:
		{

			thingy = lib.options.mkOption {

				type = lib.types.int;
				default = 5;

			};

		};

		configuration =
		enabled:
		{ final }:
		{

		

		};

	})

	(szy.objects.declare
	{
	
		callerData = {
			inherit config;
		};

		name = "program";

		#extends = [ "thing" ];

		parameters = 
		{ final }:
		{

			command = lib.options.mkOption {
				type = lib.types.str;
				default = final.meta.name;
			};

		};

		configuration =
		enabled:
		{ final }:
		{

		

		};

	})

	];

}
