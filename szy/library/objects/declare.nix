{ identifier, lib, utils, importLib, helper, ... }@gInputs:
let

	defaultNamespace = name: helper.namespaces.templates ++ lib.lists.toList name;

in
{

	declare =
	{
		config,
		name, # Name of template
		namespace ? (defaultNamespace name),
		#dataKeys ? [], # The keys to the location where the declaration's data and its definitions' data should be stored
		parameters ? {}, # A set of lib.options-style options
		templateParameters ? {}, # A set of lib.options-style options
		templateArguments ? {},
		extends ? [], # A list of templates that this one extends, by name
		#defaultEnabled ? true,
		options ? {},
		configuration ? (enabled: {}),
	}:
	let
		
		baseNamespace = defaultNamespace name;

		final = helper.getTemplate { inherit config name; };

	in
	{

		options = utils.mergeAll ([

			(utils.options.createFromKeys { keys = baseNamespace; value =
			{
				
				namespace = utils.options.constant 
				{
					type = lib.types.listOf lib.types.str;
					value = namespace;
				};

			}; })

			(utils.options.createFromKeys { keys = namespace; value =
			{
				
				meta =
				{

					name = utils.options.constant { type = lib.types.str; value = name; };

					#defaultEnabled = utils.options.constant { type = lib.types.bool; value = defaultEnabled; };

					namespace = utils.options.constant { type = lib.types.listOf lib.types.str; value = namespace; };
					baseNamespace = utils.options.constant { type = lib.types.listOf lib.types.str; value = baseNamespace; };

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
						# List of ids to the base of all definitions defining this template somehow
						definitions = utils.options.constant 
						{
							type = lib.types.listOf lib.types.str;
							value = 
							let
					
								definitions = #TODO: Update to get definitions properly. utils.options.getFromKeys { keys = helper.keys.definition; object = config; };

								/*getTemplateIds = definition:
								let
									template = helper.getTemplate { inherit callerData; id = definition.meta.template; };
								in
									builtins.map (template: template.meta.id) ((lib.lists.toList template) ++ template.meta.extendsFull);
*/
							in
								#lib.attrsets.filterAttrs (name: value: (builtins.elem final.meta.id (getTemplateIds value))) definitions;
						};
					};

				};

				data = lib.options.mkOption {

					type = 
					let

						allParameters = builtins.map 
						(template: 
						let

							base = template.meta.template.parameters;
	
							internalOptions = if (builtins.hasAttr "__functor" base) then (base { template = final; data = finalData; }) else base;

							allTemplates = (lib.lists.toList final) ++ #TODO: Get all templates with final.meta.full.extends;

						in
							internalOptions
						) allTemplates;
	
					in
						lib.types.submoduleWith { modules = builtins.map (internalOptions: { options = internalOptions; }) allInternalOptions; }; #TODO: Add enabled as a "builtin" parameter with default value true.

					default = allTemplateArguments;

				};

				# The place where all definitions defining this template live
				definitions = {

				};

			}; })

		]);

		imports = 
		let
			toggledConfiguration = lib.lists.last (gInputs.importLib.mkToggleable final.data.enabled (lib.lists.toList configuration));
			isFunction = builtins.isFunction toggledConfiguration;

			arguments =
			{
				inherit final;
			};

			result = if isFunction then (toggledConfiguration arguments) else toggledConfiguration;
		in
			lib.lists.toList result;

		/*options = 
		let

			sharedMeta = {

				name = utils.options.constant { type = lib.types.str; value = name; };
				id = utils.options.constant { type = lib.types.str; value = id; };

				defaultEnabled = utils.options.constant { type = lib.types.bool; value = defaultEnabled; };

				keys = utils.options.constant { type = lib.types.listOf lib.types.str; value = baseKeys; };
				dataKeys = utils.options.constant { type = lib.types.listOf lib.types.str; value = evalDataKeys; };

			};

		in
		utils.mergeAll ([ 
		options 
		(utils.options.createFromKeys { keys = evalDataKeys; value = 
		{
			
			options = lib.options.mkOption {

				type = 
				let

					allInternalOptions = builtins.map 
					(template: 
					let

						base = template.meta.internalOptions;

						internalOptions = if (builtins.hasAttr "__functor" base) then (base { template = final; data = finalData; }) else base;

					in
						internalOptions
					) ((lib.lists.toList final) ++ final.meta.extendsFull);

				in
					lib.types.submoduleWith { modules = builtins.map (internalOptions: { options = internalOptions; }) allInternalOptions; };

			};

			meta = sharedMeta // {

				# A declaration should be enabled only if it is used by a definition
				enabled = lib.options.mkOption {
					type = lib.types.bool;
					default = 
					let
						hasDefinitions = final ? definitions && final.definitions != {};
					in
						defaultEnabled && hasDefinitions;
				};

			};

		}; })
		(utils.options.createFromKeys { keys = baseKeys; value = 
		{

			meta = sharedMeta // {

				# A declaration should be enabled only if it is used by a definition
				enabled = lib.options.mkOption {
					type = lib.types.bool;
					default = 
					let
						hasDefinitions = final ? definitions && final.definitions != {};
					in
						defaultEnabled && hasDefinitions;
				};

				internalOptions = utils.options.constant { type = lib.types.either (lib.types.attrs) (lib.types.functionTo lib.types.attrs); value = internalOptions; };

				extends = utils.options.constant {
					type = lib.types.listOf lib.types.attrs;

					value = builtins.map (template: helper.getTemplate { inherit callerData; id = template; }) extends;
				};

				extendsFull = utils.options.constant {
					type = lib.types.listOf lib.types.attrs;

					value = 
					let

						templates = 
						let

							getExtenders = template: 
							let

								extenders = template.meta.extends;

								iterate = extenders ++ (builtins.map (template: if (template.meta.extends != []) then (getExtenders template) else []) extenders);

							in
								lib.lists.unique (lib.lists.flatten iterate);
						in
							getExtenders final;

					in
						templates;
						
				};

			};

			data = {

				parameters = utils.options.constant { type = lib.types.either (lib.types.attrs) (lib.types.functionTo lib.types.attrs); value = parameters; };

			};

			definitions = utils.options.constant {
				type = lib.types.attrs;
				value = 
				let
					
					definitions = utils.options.getFromKeys { keys = helper.keys.definition; object = config; };

					getTemplateIds = definition:
					let
						template = helper.getTemplate { inherit callerData; id = definition.meta.template; };
					in
						builtins.map (template: template.meta.id) ((lib.lists.toList template) ++ template.meta.extendsFull);

				in
					lib.attrsets.filterAttrs (name: value: (builtins.elem final.meta.id (getTemplateIds value))) definitions;
			};

		}; })
		]);*/

		/*
		imports = 
		let
			toggledConfiguration = lib.lists.last (gInputs.importLib.mkToggleable final.meta.enabled (lib.lists.toList configuration));
			isFunction = builtins.isFunction toggledConfiguration;

			arguments =
			{
				template = final; 
				data = finalData;
			};

			result = if isFunction then (toggledConfiguration arguments) else toggledConfiguration;
		in
			lib.lists.toList result;
		*/

	};

}
