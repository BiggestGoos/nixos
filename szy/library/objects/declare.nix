{ identifier, lib, utils, importLib, helper, ... }@gInputs:
{

	declare =
	{
		config,
		name, # Name of template
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

					#defaultEnabled = utils.options.constant { type = lib.types.bool; value = defaultEnabled; };

					namespace = utils.options.constant { type = lib.types.listOf lib.types.str; value = namespace; };

					parameters = utils.options.constant { type = lib.types.either (lib.types.attrs) (lib.types.functionTo lib.types.attrs); value = parameters; };

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
					
								templates = 
								let

									allTemplates = utils.options.getFromKeys { keys = helper.namespaces.templates; object = config; };

									filtered = lib.attrsets.filterAttrs (name: value: (builtins.elem final.meta.name value.meta.full.extends)) allTemplates;

									others = lib.attrsets.mapAttrsToList (name: value: value) filtered;

								in
									(lib.lists.toList final) ++ others;

								definitions = lib.lists.flatten (builtins.map (
								template: 
								let
									definitions = lib.attrsets.mapAttrsToList (name: value: value) (template.definitions or {});
								in
									builtins.map (definition: { name = definition.meta.name; template = template.meta.name; }) definitions
								) templates);

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
								default = true;
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
	
					in
						lib.types.submoduleWith { modules = builtins.map (parameters: { options = parameters; }) allParameters; };

					default = 
					let
						baseArguments = final.meta.template.arguments;
						arguments = if (builtins.hasAttr "__functor" baseArguments) then (baseArguments { inherit final; }) else baseArguments;
					in
						arguments;

					/*default = 
					let
						allArguments = builtins.map (data: data.arguments) allData;
					in
						utils.mergeAll allArguments;*/

				};

				# The place where all definitions defining this template live
				/*definitions = lib.options.mkOption
				{

					type = 
					let

						options.options =
						{

							meta = 
							{

								name = lib.options.mkOption { type = lib.types.str; };
								template = utils.options.constant { type = lib.types.str; value = final.meta.name; };

								#	defaultEnabled = utils.options.constant { type = lib.types.bool; value = defaultEnabled; };
				
								# A definition can only be enabled if all of its templates are enabled.
								#enabled = lib.options.mkOption {
								#	type = lib.types.bool;
								#	readOnly = allTemplatesEnabled;
								#	default = defaultEnabled && allTemplatesEnabled;
								#};

								namespace = utils.options.constant { type = lib.types.listOf lib.types.str; value = final.meta.namespace ++ (lib.lists.toList helper.prefixes.definitions); };
								baseNamespace = lib.options.mkOption { type = lib.types.listOf lib.types.str; };

							};

							data = lib.options.mkOption 
							{

								type = 
								let

									parametersList = builtins.map 
									(template: 
									let

										base = final.meta.parameters;

										parameters = if (builtins.hasAttr "__functor" base) then (base { inherit final; template = gTemplate; }) else base;

									in
										parameters
									) templates;

								in
									lib.types.submoduleWith { modules = builtins.map (parameters: { options = parameters; }) parametersList; };

								default =
								let
						
									base = arguments;

									evalArguments = if (builtins.hasAttr "__functor" base) then (base { inherit final; template = gTemplate; }) else base;

								in
									evalArguments;

							};

							# It might be that it isn't really possible to have the definitions automatically reside within the templates namespace, it might be so that we have to just store the definitions as a name and templateName and then to create helper functions or such to interact with the definition. Maybe, but I'd much rather get this to work somehow.

						};

					in
						lib.types.attrsOf lib.types.submoduleWith { modules = lib.lists.toList options; };

				};*/

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
