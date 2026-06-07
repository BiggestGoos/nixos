{ szy, lib, config, pkgs, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "application";
	enable = true;

	extends = [ "program" "desktopEntry" ];

	parameters =
	{ final, object }:
	{

		commands =
		{

			open = lib.options.mkOption
			{
				type = lib.types.str;
				default = final.data.commands.exec;
			};

		};

		application = 
		{

			type = lib.options.mkOption
			{
				type = 
				let
					types = 
					[
						"gui"
						"cli"
						"both"
					];
				in
					lib.types.enum types;
			};

		};

	};

}
