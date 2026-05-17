{ szy, lib, config, ... }:
szy.objects.declare
{

	callerData = { inherit config; };

	name = "defaultDefinition";

	internalOptions = 
	{ final }:
	{

		default = lib.options.mkOption {
			type = lib.types.nullOr lib.types.str;
			default = 
			let

				definitions = final.definitions;

				first = if (definitions == {}) then null else builtins.head (lib.attrsets.mapAttrsToList (name: value: value.meta.id) definitions);

			in
				first;
		};

	};

}
