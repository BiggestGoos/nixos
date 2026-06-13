{ szy, lib, config, pkgs, systemConfig, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "defaultApplication";
	enable = true;

	extends = [ "application" "default" ];

	templateArguments =
	{ final }:
	{

		defaultTypes = 
		lib.mkDefault
		{
			any = definition:
			let
				getMeta = object: { inherit (object) name template; };
				meta = getMeta definition.meta;
				guiMeta = getMeta final.data.default.gui;
				cliMeta = getMeta final.data.default.cli;
			in
				(meta == guiMeta) || (meta == cliMeta);
			gui = definition: definition.data.application.type != "cli";
			cli = definition: definition.data.application.type != "gui";
		};

	};

	configuration =
	{ enabled, final }:
	if (systemConfig)
	then
	{
	}
	else
	{

		xdg.mimeApps =
		{

			enable = true;

			defaultApplicationPackages =
			let
				inherit (config."${szy}".applications) default;

				rawDefaults =
				lib.attrsets.mapAttrsToList
				(
					name: value:
						value.any
				)
				default;

				defaults =
				builtins.filter
				(
					default:
						default != null
				)
				rawDefaults;
			in
			builtins.map
			(
				default:
					default.package
			)
			defaults;

		};

	};

}
