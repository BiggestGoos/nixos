{ szy, config, lib, pkgs, ... }:
szy.objects.declare
{
	
	callerData = {
		inherit config;
	};

	name = "program";

	parameters = 
	{ final }:
	{

		command = lib.options.mkOption {
			type = lib.types.str;
			default = final.meta.name;
		};

		test = lib.options.mkOption {
			type = lib.types.str;
			default = "test";
		};

	};

	configuration =
	enabled:
	{ final }:
	{

		

	};

}
