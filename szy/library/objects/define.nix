{ identifier, lib, utils, importLib, helper, ... }@gInputs:
{

	define = 
	{
		config,
		template,
		extends ? [],
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

		templates = [ gTemplate ] ++ (builtins.map (name: helper.getTemplate { inherit config name; }) final.meta.full.extends);

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
	
					extends = utils.options.constant { type = lib.types.listOf lib.types.str; value = extends ++ gTemplate.meta.extends; };

					full.extends = utils.options.constant 
					{
						type = lib.types.listOf lib.types.str;
						value =
						let
							templates = [ gTemplate ] ++ (builtins.map (name: helper.getTemplate { inherit config name; }) extends);
							allExtends = lib.lists.unique (extends ++ (builtins.concatLists (builtins.map (template: template.meta.full.extends) templates)));
						in
							allExtends;
					};

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
								default = 
								let
									allTemplatesEnabled = lib.lists.all (template: template.data.enabled) templates;
								in
									final.data.enable && allTemplatesEnabled;
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
