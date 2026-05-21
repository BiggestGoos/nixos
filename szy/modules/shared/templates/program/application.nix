{ szy, lib, config, pkgs, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "application";
	enable = true;

	extends = [ "program" ];

	parameters =
	{ final, object }:
	{

		application = 
		{

			desktopEntry = lib.options.mkOption
			{
				type = lib.types.strMatching ".*[.]desktop";
				default = 
				let
					path = "${final.data.package}/share/applications/${final.meta.name}.desktop";
					entryExists = builtins.pathExists path;
				in
					if entryExists then path else "Default Desktop Entry for { ${final.meta.name} } can't be found.";
			};

			type = lib.options.mkOption
			{
				type = 
				let
					types = 
					[
						"gui"
						"other"
					];
					terminalTypes =
					[
						"cli"
						"tui"
					];
				in
					lib.types.either 
					(lib.types.enum (types ++ terminalTypes)) 
					(lib.types.submodule 
					{  
						options = 
						{
							type = lib.options.mkOption { type = lib.types.enum terminalTypes; };
							preferredTerminal = lib.options.mkOption { type = lib.types.str; };
						};
					});
			};

		};

	};

}
