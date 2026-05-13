{ szy, config, lib, pkgs, ... }:
szy.objects.declare
{
	
	callerData = {
		inherit config;
	};

	name = "program-gui";

	extends = [ "program" ];

	definable = true;

	parameters = 
	{ final }:
	{

		test2 = lib.options.mkOption {
			type = lib.types.str;
			default = "test2";
		};

	};

	configuration =
	enabled:
	{ final }:
	{

		

	};

}
