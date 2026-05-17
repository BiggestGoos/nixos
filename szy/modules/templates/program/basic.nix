{ szy, lib, config, ... }:
szy.objects.declare
{

	callerData = { inherit config; };

	name = "program";

	extends = [ "defaultDefinition" ];
	
	parameters = 
	{ final }:
	{

		command = lib.options.mkOption {
			type = lib.types.str;
			default = final.meta.name;
		};

	};

}
