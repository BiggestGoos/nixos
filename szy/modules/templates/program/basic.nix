{ szy, lib, config, ... }:
szy.objects.declare
{

	inherit config;

	name = "program";
	
	extends = [ "defaultDefinition" ];
	
	parameters = 
	{ final, object }:
	{

		command = lib.options.mkOption {
			type = lib.types.str;
			default = final.meta.name;
		};

	};

}
