{ szy, lib, config, pkgs, ... }:
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

}
