{ szy, lib, config, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "default";

	enable = true;

	templateParameters = 
	{ final }:
	{

		default =
		let
			definitionsBase = builtins.attrNames (final.definitions or {});
			allDefinitionsBase = final.meta.full.definitions;

			definitions = builtins.filter (definition: final.definitions."${definition}".data.enabled) definitionsBase;
			allDefinitions = builtins.filter (definition: (szy.objects.helper.getDefinition ({ inherit config; } // definition)).data.enabled) allDefinitionsBase;

		in
		{

			name = lib.options.mkOption
			{
				type = lib.types.nullOr (lib.types.enum (builtins.map (definition: definition.name) allDefinitions));
				default = if (definitions == []) then null else (builtins.head definitions);
			};

			template = lib.options.mkOption
			{
				type = lib.types.nullOr (lib.types.enum (builtins.map (definition: definition.template) allDefinitions));
				default = if (builtins.elem final.data.default.name definitions) then final.meta.name else "The template { ${final.meta.name} } does not have a definition called { ${final.meta.name} }.";
			};

		};

	};

	parameters =
	{ final, object }:
	{

		isDefault = lib.options.mkOption {
			type = lib.types.bool;
			readOnly = true;
			default = { inherit (final.meta) name template; } == object.data.default;
		};

	};

}
