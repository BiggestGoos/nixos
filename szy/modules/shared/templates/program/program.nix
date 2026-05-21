{ szy, lib, config, pkgs, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "program";
	enable = true;

	extends = [ "package" ];

	parameters =
	{ final, object }:
	{

		commands = 
		{
			exec = lib.options.mkOption
			{
				type = lib.types.str;
				default = 
				let
					exe = lib.meta.getExe final.data.package;
				in
					exe;
			};
		};

	};

}
