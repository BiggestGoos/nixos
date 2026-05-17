{ identifier, lib, utils, importLib, helper, ... }@gInputs:
{

	define = 
	{
		config,
		template,
		name,
		#id ? "${template}+${name}",
		arguments ? {},
		#defaultEnabled ? true,
		options ? {},
		configuration ? (enabled: {}),
	}@inputs:
	let

		baseNamespace = helper.namespaces.definitions ++ lib.lists.toList name;

		template = helper.getTemplate { inherit config; name = inputs.template; };
		templates = (lib.lists.toList template) ++ (builtins.map (name: helper.getTemplate { inherit config name; }) template.meta.full.extends);

		final = utils.options.getFromKeys { keys = baseKeys; object = callerData.config; };

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

		]);

/*
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

						base = template.data.parameters;

						parameters = if (builtins.hasAttr "__functor" base) then (base { inherit final; }) else base;

					in
						parameters
					) templates;

				in
					lib.types.submoduleWith { modules = builtins.map (parameters: { options = parameters; }) parametersList; };

				default =
				let
						
					base = arguments;

					evalArguments = if (builtins.hasAttr "__functor" base) then (base { inherit final; }) else base;

				in
					evalArguments;

			};

		}; }) options ];
*/
/*
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
*/
}
