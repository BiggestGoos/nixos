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

			desktopEntry = 
			let
				required = !(final.data.application.type == "terminal");
				base = lib.types.strMatching ".*[.]desktop";
			in
			lib.options.mkOption
			{
				type = if !required then (lib.types.nullOr base) else base;
				default = 
				let
					path = "${final.data.package}/share/applications/${final.meta.name}.desktop";
					entryExists = builtins.pathExists path;
					noneFound = if required then "No Desktop Entry was found for application { ${final.meta.name} }. Set a value manually." else null;
				in
					if entryExists then path else noneFound;
			};

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
