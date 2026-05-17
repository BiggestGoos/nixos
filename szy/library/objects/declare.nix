{ identifier, lib, utils, meta, importLib, helper, ... }@gInputs:
{

	declare =
	{
		callerData,
		name, # The name of the template
		id ? name, # Id of template, default to the name
		parameters ? {}, # A set of lib.options-style options
		extends ? [], # A list of templates that this one extends, by id
		defaultEnabled ? true,
		definable ? false,
		options ? {},
		internalOptions ? {},
		configuration ? (enabled: {}),
	}:
	let
		
		baseKeys = helper.keys.template ++ lib.lists.toList id;

		inherit (callerData) config;

		final = helper.getTemplate { inherit callerData id; };

	in
	if !(meta.callerData { data = callerData; requiredFields = [ "config" ]; }) then null else
	{

		options = 
		let

			allInternalOptions =
			(
				lib.attrsets.mapAttrsToList 
				(name: value: 
					if !(builtins.isFunction value.meta.internalOptions) then value.meta.internalOptions else value.meta.internalOptions { inherit final; }
				) 
				(lib.lists.toList final) ++ final.meta.extendsFull
			);

		in
		utils.mergeAll ([ options (utils.options.createFromKeys { keys = baseKeys; value = 
		{

			options = lib.options.mkOption {

				type = 
				let

					allInternalOptions = builtins.map 
					(template: 
					let

						base = template.meta.internalOptions;

						internalOptions = if (builtins.hasAttr "__functor" base) then (base { inherit final; }) else base;

					in
						internalOptions
					) ((lib.lists.toList final) ++ final.meta.extendsFull);

				in
					lib.types.submoduleWith { modules = builtins.map (internalOptions: { options = internalOptions; }) allInternalOptions; };

			};

			meta = {

				name = utils.options.constant { type = lib.types.str; value = name; };
				id = utils.options.constant { type = lib.types.str; value = id; };

				defaultEnabled = utils.options.constant { type = lib.types.bool; value = defaultEnabled; };
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

				keys = utils.options.constant { type = lib.types.listOf lib.types.str; value = baseKeys; };
				definable = utils.options.constant { type = lib.types.bool; value = definable; };

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

		}; }) ]);

		imports = 
		let
			toggledConfiguration = lib.lists.last (gInputs.importLib.mkToggleable final.meta.enabled (lib.lists.toList configuration));
			isFunction = builtins.isFunction toggledConfiguration;

			arguments =
			{
				inherit final;
			};

			result = if isFunction then (toggledConfiguration arguments) else toggledConfiguration;
		in
			lib.lists.toList result;

	};

}
