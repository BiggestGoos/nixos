{ config, options, lib, utils, ... }:
let

	optionsName = options;

	values.options = {

		command = lib.mkOption {
			type = lib.types.str;
		};
	
		package = lib.mkOption {
			type = lib.types.package;
		};

	};

in
{

	mkProgram = { config, name, configuration ? {}, additionalValues ? [] }:
	let
		
		resolvedAdditionalValues.options = builtins.listToAttrs (builtins.map (value: { name = value; value = lib.mkOption { type = lib.types.str; }; }) additionalValues);

		finalValues = config."${options}".programs."${name}".default.values;

	in
	{

		imports = [ (if (builtins.isFunction configuration) then (configuration { values = finalValues; }) else configuration) ];

		options."${options}".programs."${name}" = 
		let

			available = config."${options}".programs."${name}".available;

		in
		{

			available = lib.mkOption {
				type = lib.types.listOf lib.types.str;
				readOnly = true;
				default = builtins.attrNames config."${options}".programs."${name}".instances or {};
			};

			default = 
			let
				defaultName = config."${options}".programs."${name}".default.name;
				valuesType = config."${options}".programs."${name}".default.valuesType;
			in
			{

				name = lib.mkOption {
					type = lib.types.nullOr (lib.types.enum available);
					default = if (available != []) then (builtins.elemAt available 0) else null;
				};

				values = lib.mkOption {
					type = valuesType;
					readOnly = true;
					default = if (defaultName != null) then config."${options}".programs."${name}".instances."${defaultName}".values else {};
				};

				valuesType = lib.mkOption {
					type = lib.types.attrs;
					readOnly = true;
					default = lib.types.submoduleWith { modules = [ values resolvedAdditionalValues ]; };
				};

			};

		};

	};

	mkInstance = { config, program, name, configuration ? {}, values }:
	let

		command = finalValues.command;
		resolvedValues = if (builtins.isFunction values) then values { inherit command; } else values;

		finalValues = config."${optionsName}".programs."${program}".instances."${name}".values;

	in
	{

		imports = [ (if (builtins.isFunction configuration) then (configuration { values = finalValues; optionKeys = [ "programs" "${program}" "instances" "${name}" ]; }) else configuration) ];
		
		options."${optionsName}".programs."${program}".instances."${name}" = {

			values = lib.mkOption {
				type = config."${options}".programs."${program}".default.valuesType;
				readOnly = true;
			};

		};

		config."${optionsName}".programs."${program}".instances."${name}".values = lib.mkDefault (if (builtins.elem "command" (builtins.attrNames resolvedValues)) then resolvedValues else (resolvedValues // { command = lib.meta.getExe resolvedValues.package; }));

	};

}
