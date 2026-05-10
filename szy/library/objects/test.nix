{ identifier, lib, utils, meta, import, ... }@gInputs:
let

	gBaseIdentifier = "objects";

	gBaseKeys = [ gInputs.identifier gBaseIdentifier ];

in
{

	declare =
	{
		callerData,
		name,
		parameters, # A set of lib.options-style options
		defaultEnabled ? true,
		definable ? false,
		options ? {},
		internalOptions ? {},
		configuration ? {},
	}:
	let
		baseIdentifier = "template";
		baseKeys = gBaseKeys ++ [ baseIdentifier name ];

		inherit (callerData) config;

		final = rec {

			self = utils.options.getFromKeys { object = config; keys = baseKeys; };
			inherit (self) meta;

		};

	in
	if !(meta.callerData { data = callerData; requiredFields = [ "config" ]; }) then null else
	{

		options = utils.mergeAll [ (utils.options.createFromKeys { keys = baseKeys; value = utils.mergeAll [ ({

			meta = {

				name = utils.options.constant { type = lib.types.str; value = name; };

				defaultEnabled = utils.options.constant { type = lib.types.bool; value = defaultEnabled; };
				# A declaration should be enabled only if it is used by an enabled definition
				enabled = lib.options.mkOption {
					type = lib.types.anything;
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

		}) internalOptions ]; }) options ];

		imports = 
		let
			toggledConfiguration = lib.lists.last (gInputs.import.mkToggleable final.meta.enabled (lib.lists.toList configuration));
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
