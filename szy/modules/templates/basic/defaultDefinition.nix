{ szy, lib, config, ... }:
let

	callerData = { inherit config; };

in
szy.objects.declare
{

	inherit callerData;
	
	name = "defaultDefinition";

	internalOptions = 
	{ template, data }:
	{

		default = lib.options.mkOption {
			type = lib.types.nullOr lib.types.str;
			default = 
			let

				definitions = data.definitions or {};

				first = if (definitions == {}) then null else builtins.head (lib.attrsets.mapAttrsToList (name: value: value.meta.name) definitions);

			in
				first;
		};

	};

	parameters =
	{ final }:
	{

		isDefault = lib.options.mkOption {
			type = lib.types.bool;
			readOnly = true;
			default = 
			let
				template = szy.objects.helper.getTemplate { inherit callerData; id = final.meta.template; };
			in
				final.meta.name == template.options.default;
		};

	};

}
