{ identifier, lib, utils, meta, importLib, helper, ... }@gInputs:
{

	declare =
	{
		callerData,
		name, # The name of the template
		id ? name, # Id of template, default to the name
		parameters, # A set of lib.options-style options
		extends ? [], # A list of templates that this one extends, by id
		defaultEnabled ? true,
		definable ? false,
		options ? {},
		configuration ? {},
	}:
	let
		
		baseKeys = helper.keys.template ++ lib.lists.toList id;

		inherit (callerData) config;

		final = helper.getTemplate { inherit callerData id; };

	in
	if !(meta.callerData { data = callerData; requiredFields = [ "config" ]; }) then null else
	{

		options = utils.mergeAll [ (utils.options.createFromKeys { keys = baseKeys; value = {

			meta = {

				name = utils.options.constant { type = lib.types.str; value = name; };
				id = utils.options.constant { type = lib.types.str; value = id; };

				defaultEnabled = utils.options.constant { type = lib.types.bool; value = defaultEnabled; };
				# A declaration should be enabled only if it is used by an enabled definition
				enabled = lib.options.mkOption {
					type = lib.types.bool;
					default = 
					let
						inherit (final) self;
						hasDefinitions = self ? definitions && self.definitions != {};
						hasEnabledDefinition = lib.lists.any (enabled: enabled == true) (lib.attrsets.mapAttrsToList (name: value: value.meta.enabled) self.definitions);
					in
						defaultEnabled && hasDefinitions && hasEnabledDefinition;
				};

				keys = utils.options.constant { type = lib.types.listOf lib.types.str; value = baseKeys; };
				definable = utils.options.constant { type = lib.types.bool; value = definable; };

			};

			data = {

				parameters = utils.options.constant { type = lib.types.either (lib.types.attrs) (lib.types.functionTo lib.types.attrs); value = parameters; };

			};

		}; }) options ];

		

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
