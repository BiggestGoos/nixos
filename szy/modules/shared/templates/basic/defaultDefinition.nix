{ szy, lib, config, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "default";

	enable = true;

	templateParameters = 
	{ final }:
	{

		defaultTypes = lib.options.mkOption
		{
			type = lib.types.attrsOf (lib.types.functionTo lib.types.bool);
			default = {}; # { <name> = filter; }
		};

		default	=
		let

			types = final.data.defaultTypes;

			definitionsBase = lib.attrsets.mapAttrsToList (name: value: { inherit (value.meta) name template; }) (final.definitions or {});
			allDefinitionsBase = final.meta.full.definitions;

			gDefinitions = builtins.filter (definition: final.definitions."${definition.name}".data.enabled) definitionsBase;
			gAllDefinitions = builtins.filter (definition: (szy.objects.helper.getDefinition ({ inherit config; inherit (definition) name template; })).data.enabled) allDefinitionsBase;

			base = 
			{ typeName, filterFunc }:
			let

				definitions = builtins.filter filterFunc (builtins.map (definition: szy.objects.helper.getDefinition { inherit config; inherit (definition) name template; }) gDefinitions);
				allDefinitions = builtins.filter filterFunc (builtins.map (definition: szy.objects.helper.getDefinition { inherit config; inherit (definition) name template; }) gAllDefinitions);

				defaultDefinition = if (allDefinitions == []) then null else (builtins.head allDefinitions);
				defaultName = if (defaultDefinition == null) then null else defaultDefinition.meta.name;
				defaultTemplate = if (defaultDefinition == null) then null else defaultDefinition.meta.template;

				name = final.data.default.name or final.data.default."${typeName}".name;
				template = final.data.default.template or final.data.default."${typeName}".template;

			in
			{

				name = lib.options.mkOption
				{
					type = lib.types.nullOr (lib.types.enum (builtins.map (definition: definition.meta.name) allDefinitions));
					default = defaultName;
				};

				template = lib.options.mkOption
				{
					type = lib.types.nullOr (lib.types.enum (builtins.map (definition: definition.meta.template) allDefinitions));
					default = 
					if (name == null) 
					then null 
					else 
					(
						if (name == defaultName) 
						then defaultTemplate 
						else 
						(
							if (builtins.elem name (builtins.map (definition: definition.meta.name) definitions)) 
							then final.meta.name 
							else "The template { ${final.meta.name} } does not have a definition called { ${name} }."));
				};

				value = lib.options.mkOption
				{
					type = lib.types.nullOr lib.types.attrs;
					readOnly = true;
					default = if (name == null || template == null) then null else szy.objects.helper.getDefinition { inherit config name template; };
				};

			};

			modules = 
			if (types == {})
			then [ { options = (base { typeName = ""; filterFunc = (definition: true); }); } ]
			else [ { options = (lib.attrsets.mapAttrs 
			(
				name: value:
				base { typeName = name; filterFunc = value; }
			)
			types
			); } ];
			

		in
		lib.options.mkOption
		{
		
			type = lib.types.submoduleWith { inherit modules; };

		};

	};

}
