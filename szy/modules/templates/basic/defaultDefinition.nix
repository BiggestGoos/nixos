{ szy, lib, config, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "defaultDefinition";

	templateArguments = 
	{

		enable = true;

	};
	
	templateParameters = 
	{ final }:
	{

		default = lib.options.mkOption {
			type = lib.types.nullOr lib.types.str;
			default = 
			let

				definitions = szy.objects.helper.getAllDefinitions { inherit config; template = final.meta.name; };

				first = if (definitions == {}) then null else builtins.head (lib.attrsets.mapAttrsToList (name: value: value.meta.name) definitions);

			in
				first;
		};

	};

	parameters =
	{ final, object }:
	{

		isDefault = lib.options.mkOption {
			type = lib.types.bool;
			readOnly = true;
			default = 
			let
				template = szy.objects.helper.getTemplate { inherit config; name = final.meta.template; };
			in
				final.meta.name == template.data.default;
		};

	};

}
