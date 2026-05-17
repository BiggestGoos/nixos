{ identifier, lib, utils, meta, importLib, helper, ... }@gInputs:
{

	define = 
	{
		callerData,
		template,
		name,
		id ? "${template}+${name}",
		arguments ? {},
		defaultEnabled ? true,
		options ? {},
		configuration ? (enabled: {}),
	}@inputs:
	let

		baseKeys = helper.keys.definition ++ lib.lists.toList id;

		template = helper.getTemplate { inherit callerData; id = inputs.template; };

		templates = (lib.lists.toList template) ++ template.meta.extendsFull;

		final = if (template.meta.definable) then utils.options.getFromKeys { keys = baseKeys; object = callerData.config; } else builtins.abort "Template ${template.meta.id} is not definable." null;

	in
	if !(meta.callerData { data = callerData; requiredFields = [ "config" ]; }) then null else
	{

		options = utils.mergeAll [ (utils.options.createFromKeys { keys = baseKeys; value = {

			meta = 
			let

				allTemplatesEnabled = lib.lists.all (template: template.meta.enabled) templates;

			in
			{

				name = utils.options.constant { type = lib.types.str; value = name; };
				template = utils.options.constant { type = lib.types.str; value = inputs.template; };
				id = utils.options.constant { type = lib.types.str; value = id; };

				defaultEnabled = utils.options.constant { type = lib.types.bool; value = defaultEnabled; };
				
				# A definition can only be enabled if all of its templates are enabled.
				enabled = lib.options.mkOption {
					type = lib.types.bool;
					readOnly = allTemplatesEnabled;
					default = defaultEnabled && allTemplatesEnabled;
				};

				keys = utils.options.constant { type = lib.types.listOf lib.types.str; value = baseKeys; };

			};

			data = lib.options.mkOption {

				type = 
				let

					parametersList = builtins.map 
					(template: 
					let

						baseParameters = template.data.parameters;

						parameters = if (builtins.hasAttr "__functor" baseParameters) then (baseParameters { inherit final; }) else baseParameters;

					in
						parameters
					) templates;

				in
					lib.types.submoduleWith { modules = builtins.map (parameters: { options = parameters; }) parametersList; };

				default = arguments { inherit final; };

			};

		}; }) options ];

		imports = 
		let
			toggledConfiguration = lib.lists.last (gInputs.importLib.mkToggleable (final.meta.enabled) (lib.lists.toList configuration));
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
