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
		configuration ? {},
	}@inputs:
	let

		baseKeys = helper.keys.definition ++ lib.lists.toList id;

		template = helper.getTemplate { inherit callerData; id = inputs.template; };

		final = utils.options.getFromKeys { keys = baseKeys; object = callerData.config; };

	in
	if !(meta.callerData { data = callerData; requiredFields = [ "config" ]; }) then null else
	{

		options = utils.mergeAll [ (utils.options.createFromKeys { keys = baseKeys; value = {

			meta = {

				name = utils.options.constant { type = lib.types.str; value = name; };
				template = utils.options.constant { type = lib.types.str; value = inputs.template; };
				id = utils.options.constant { type = lib.types.str; value = id; };

				defaultEnabled = utils.options.constant { type = lib.types.bool; value = defaultEnabled; };
					
				enabled = lib.options.mkOption {
					type = lib.types.bool;
					default = defaultEnabled;
				};

				keys = utils.options.constant { type = lib.types.listOf lib.types.str; value = baseKeys; };

			};

			data = lib.options.mkOption {

				type = 
				let

					baseParameters = template.data.parameters;

					parameters = if (builtins.hasAttr "__functor" baseParameters) then (baseParameters { inherit final; }) else baseParameters;

				in
					lib.types.submoduleWith { modules = lib.lists.toList { options = parameters; }; };

				default = arguments { inherit final; };

			};

		}; }) options ];

	};

}
