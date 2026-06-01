{ identifier, lib, utils, importLib, helper, qualifiers, ... }@gInputs:
rec {

	define =
	{ 
		config,
		template,
		name,
		qualifiers ? {}, # { <qualifier> = { <arguments> }; }
		...
	}@inputs:
	let
		output = _define inputs;

		order = qualifiers._meta.order or (builtins.attrNames qualifiers);

		qualifiersList = 
		builtins.map
		(
			name: 
				gInputs.qualifiers."${name}" (qualifiers."${name}")
		)
		order;

		resolve = lib.lists.foldl (data: qualifier: (qualifier config) data) output;

		result = resolve qualifiersList;
	in
		result;

	_define = 
	{
		config,
		template,
		extends ? [],
		qualifiers ? [],
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
				
				meta = lib.options.mkOption
				{

					type = 
					let

						module =
						{

							options =
							{

								name = utils.options.constant { type = lib.types.str; value = name; };
								template = utils.options.constant { type = lib.types.str; value = inputs.template; };

								namespace = utils.options.constant { type = lib.types.listOf lib.types.str; value = namespace; };
	
								extends = lib.options.mkOption { type = lib.types.listOf lib.types.str; };
	
								full.extends = utils.options.constant 
								{
									type = lib.types.listOf lib.types.str;
									value =
									let
										templates = [ gTemplate ] ++ (builtins.map (name: helper.getTemplate { inherit config name; }) final.meta.extends);
										allExtends = lib.lists.unique (final.meta.extends ++ (builtins.concatLists (builtins.map (template: template.meta.full.extends) templates)));
									in
										allExtends;
								};

							};

							config.extends = extends;

						};

					in
						lib.types.submoduleWith { modules = [ module ]; };

				};

				data = lib.options.mkOption 
				{

					type = 
					let

						evaluateOption = data: if (builtins.hasAttr "__functor" data) then (data { inherit final; object = gTemplate; }) else data;
						evaluateRaw = data: if (builtins.isFunction data) then (data { inherit final; object = gTemplate; }) else data;

						parametersList = builtins.map (template: evaluateOption template.meta.parameters) templates;

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

						allParameters = [ builtinParameters (evaluateRaw additionalParameters) ] ++ parametersList;

						argumentsList = builtins.map (template: evaluateOption template.meta.defaultArguments) templates;

						allArguments = [ (evaluateRaw arguments) ] ++ argumentsList;

					in
						lib.types.submoduleWith { modules = (builtins.map (parameters: { options = parameters; }) allParameters) ++ allArguments; };

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
