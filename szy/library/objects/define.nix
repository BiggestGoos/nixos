{ identifier, lib, utils, importLib, helper, ... }@gInputs:
{

	define = 
	{
		config,
		template,
		name,
		enable ? false,
		arguments ? {},
		additionalParameters ? {},
		options ? {},
		configuration ? (enabled: {}),
	}@inputs:
	let

		namespace = helper.namespaces.definitions ++ [ template helper.prefixes.definitions name ];
	
		gTemplate = helper.getTemplate { inherit config; name = template; };
		templates = (lib.lists.toList gTemplate) ++ (helper.getAllExtenders { inherit config; name = inputs.template; });

		final = helper.getDefinition { inherit config name template; };

	in
	{

		options = utils.mergeAll ([

			options

			(utils.options.createFromKeys { keys = namespace; value =
			{
				
				meta = 
				{

					name = utils.options.constant { type = lib.types.str; value = name; };
					template = utils.options.constant { type = lib.types.str; value = inputs.template; };

					namespace = utils.options.constant { type = lib.types.listOf lib.types.str; value = namespace; };
	
				};

				data = lib.options.mkOption 
				{

					type = 
					let

						evaluateParameters = parameters: if (builtins.hasAttr "__functor" parameters) then (parameters { inherit final; object = gTemplate; }) else parameters;

						parametersList = builtins.map (template: evaluateParameters template.meta.parameters) templates;

						builtinParameters =
						{

							enable = lib.options.mkOption
							{
								type = lib.types.bool;
								default = enable;
							};

							enabled = lib.options.mkOption 
							{
								type = lib.types.bool;
								default = final.data.enable && gTemplate.data.enabled;
							};

						};

						allParameters = [ builtinParameters (evaluateParameters additionalParameters) ] ++ parametersList;

						evalArguments = if (builtins.isFunction arguments) then (arguments { inherit final; object = gTemplate; }) else arguments;

					in
						lib.types.submoduleWith { modules = (builtins.map (parameters: { options = parameters; }) allParameters) ++ [ evalArguments ]; };

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
				object = gTemplate;
			};

			result = if isFunction then (toggledConfiguration arguments) else toggledConfiguration;
		in
		[
			result
		];

	};

}
