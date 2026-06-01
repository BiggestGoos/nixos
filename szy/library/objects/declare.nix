{ identifier, lib, utils, importLib, helper, qualifiers, ... }@gInputs:
{

	declare =
	{
		config,
		name, # Name of template
		enable ? false,
		parameters ? {}, # A set of lib.options-style options
		defaultArguments ? {},
		templateParameters ? {}, # A set of lib.options-style options
		templateArguments ? {},
		extends ? [], # A list of templates that this one extends, by name
		options ? {},
		configuration ? (enabled: {}),
	}:
	let
		
		namespace = helper.namespaces.templates ++ lib.lists.toList name;

		final = helper.getTemplate { inherit config name; };

	in
	{

		options = utils.mergeAll ([

			options

			(utils.options.createFromKeys { keys = namespace; value =
			{
				
				meta =
				{

					name = utils.options.constant { type = lib.types.str; value = name; };
	
					namespace = utils.options.constant { type = lib.types.listOf lib.types.str; value = namespace; };

					parameters = utils.options.constant { type = lib.types.either (lib.types.attrs) (lib.types.functionTo lib.types.attrs); value = parameters; };
					defaultArguments = utils.options.constant { type = lib.types.either (lib.types.attrs) (lib.types.functionTo lib.types.attrs); value = defaultArguments; };

					template = 
					{
						parameters = utils.options.constant { type = lib.types.either (lib.types.attrs) (lib.types.functionTo lib.types.attrs); value = templateParameters; };
						arguments = utils.options.constant { type = lib.types.either (lib.types.attrs) (lib.types.functionTo lib.types.attrs); value = templateArguments; };
					};

					extends = utils.options.constant {
						type = lib.types.listOf lib.types.str;

						value = extends;
					};

					full = 
					{
						extends = utils.options.constant 
						{
							type = lib.types.listOf lib.types.str;

							value = 
							let
								allExtenders = builtins.map (template: template.meta.name) (helper.getAllExtenders { inherit config name; });
							in
								allExtenders;
						
						};
						# List of the template and name of all definitions that define this template
						definitions = utils.options.constant 
						{
							type = lib.types.listOf lib.types.attrs;
							value = 
							let
					
								allTemplates = utils.options.getFromKeys { keys = helper.namespaces.templates; object = config; };
								allDefinitions = 
								lib.lists.flatten
								(lib.attrsets.mapAttrsToList 
								(
									name: value: 
									(
										lib.attrsets.mapAttrsToList 
										(
											name: value: 
											value
										) 
										(value.definitions or {})
									)
								) 
								allTemplates);

								definitions = 
								builtins.map 
								(
									definition: 
									{ 
										inherit (definition.meta) name template; 
									}
								) 
								(
									builtins.filter 
									(
										definition: 
										(builtins.elem final.meta.name definition.meta.full.extends) || (definition.meta.template == final.meta.name)
									) 
									allDefinitions
								);

							in
								definitions;
						};
					};

				};

				data = 
				let

					allData = 
					let
						allTemplates = (lib.lists.toList final) ++ (helper.getAllExtenders { inherit config; inherit (final.meta) name; });
					in
						(builtins.map 
						(template: 
						let

							baseParameters = template.meta.template.parameters;
							baseArguments = template.meta.template.arguments;
	
							parameters = if (builtins.hasAttr "__functor" baseParameters) then (baseParameters { inherit final; }) else baseParameters;
							arguments = if (builtins.hasAttr "__functor" baseArguments) then (baseArguments { inherit final; }) else baseArguments;

						in
							{
								inherit parameters arguments;
							}
						) allTemplates);

				in
				lib.options.mkOption 
				{

					type = 
					let

						allParameters = (lib.lists.toList builtinParameters) ++ (builtins.map (data: data.parameters) allData);

						builtinParameters =
						{

							enable = lib.options.mkOption {
								type = lib.types.bool;
								default = enable;
							};

							enabled = 
							let
								hasDefinitions = final.meta.full.definitions != {};
								allExtendersEnabled = lib.lists.all (template: template.data.enabled) (helper.getAllExtenders { inherit config; inherit (final.meta) name; });
								combined = hasDefinitions && allExtendersEnabled;
							in
							lib.options.mkOption {
								type = lib.types.bool;
								readOnly = true;
								default = final.data.enable && combined;
							};

						};

						allArguments = (builtins.map (data: data.arguments) allData);
	
					in
						lib.types.submoduleWith { modules = (builtins.map (parameters: { options = parameters; }) allParameters) ++ allArguments; };

				};

			}; })

		]);

		imports = 
		let
			anyDefinitionEnabled = lib.lists.any (definition: definition.data.enabled) (builtins.map (definition: helper.getDefinition ({ inherit config; } // definition)) final.meta.full.definitions);

			toggledConfiguration = lib.lists.last (gInputs.importLib.mkToggleable (final.data.enabled && anyDefinitionEnabled) (lib.lists.toList configuration));
			isFunction = builtins.isFunction toggledConfiguration;

			arguments =
			{
				inherit final;
			};

			result = if isFunction then (toggledConfiguration arguments) else toggledConfiguration;
		in
		[
			result
		];

	};

}
