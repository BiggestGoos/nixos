{ config, lib, options, utils }:
rec {
	
	mkDesktop = { name, enabled ? [], imports ? [], configuration ? { ... }: {}, additionalOptions ? {}, variants ? [] }:
	let
		
		resolvedVariants = [ { names = []; variants = []; } ] ++ variants;

	in
	{
		
		options = (utils.mergeAll [ (utils.mergeAll [ {

			"${options}".desktops.desktops = (builtins.listToAttrs (builtins.map (variant: 
			let
				resolvedNames = [ name ] ++ variant.names;
				resolvedName = lib.strings.concatStringsSep "+" (resolvedNames);
				isEnabled = (builtins.elem variant.names config."${options}".desktops.desktops."${name}".variants);
			in
			{

				name = resolvedName;
				
				value = {

					names = lib.mkOption {
						type = lib.types.listOf lib.types.str;
						readOnly = true;
						default = [ name ] ++ variant.names;
					};

					isEnabled = lib.mkOption {
						type = lib.types.bool;
						readOnly = true;
						default = if (isEnabled == null) then false else isEnabled;
					};

					enabled = lib.mkOption {
						type = lib.types.listOf (lib.types.enum config."${options}".desktops.available);
						readOnly = true;
						default = [ resolvedName ] ++ enabled;
					};

					imports = lib.mkOption {
						type = lib.types.listOf lib.types.path;
						readOnly = true;
						default = imports;
					};

					configuration = lib.mkOption {
						type = lib.types.attrs;
						readOnly = true;
						default = { __functor = (self: ({ desktop, ... }@args: (utils.mergeAll [ (configuration { inherit desktop args; }) 
						(lib.optionalAttrs ((builtins.length variant.variants) != 0) { 
							
							"${options}".desktops.desktops."${name}".enabledVariants = variant.variants;

						}) ]))); };
					};

				};

			}) resolvedVariants));
		} additionalOptions ]) ({ 

			"${options}".desktops.desktops."${name}".variants = lib.mkOption {
				type = lib.types.listOf (lib.types.enum (builtins.map (variant: variant.names) resolvedVariants));
				default = [ [] ];
			};

		}) ]);

	};

}
