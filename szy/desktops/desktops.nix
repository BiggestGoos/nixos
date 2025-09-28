{ config, lib, options, utils }:
rec {
	
	mkDesktop = { name, enabled ? [], imports ? [], configuration ? { ... }: {}, additionalOptions ? {}, variants ? [] }:
	let
		
		resolvedVariants = [ { names = []; variants = []; } ] ++ variants;

	in
	{
		
		options = (utils.mergeAll [ {

			"${options}".desktops.desktops = (builtins.listToAttrs (builtins.map (variant: 
			let
				resolvedName = lib.strings.concatStringsSep "+" ([ name ] ++ variant.names);
			in
			{

				name = resolvedName;
				
				value = {

					names = lib.mkOption {
						type = lib.types.listOf lib.types.str;
						readOnly = true;
						default = [ name ] ++ variant.names;
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
		} additionalOptions ]);

/*		options = (utils.mergeAll [ {

			"${options}".desktops.desktops."${name}" = {
			
				enabled = lib.mkOption {
					type = lib.types.listOf (lib.types.enum config."${options}".desktops.available);
					readOnly = true;
					default = [ name ] ++ enabled;
				};

				imports = lib.mkOption {
					type = lib.types.listOf lib.types.path;
					readOnly = true;
					default = imports;
				};

				configuration = lib.mkOption {
					type = lib.types.attrs;
					readOnly = true;
					default = { __functor = (self: ({ desktop, ... }@args: (configuration { inherit desktop args; }))); };
				};

				variants = lib.mkOption {
					type = 
					let
						template.options = {

							names = lib.mkOption {
								type = lib.types.listOf lib.types.str;
							};

							variants = lib.mkOption {
								type = lib.types.listOf (lib.types.enum config."${options}".desktops.desktops."${name}".availableVariants);
							};

						};
					in
						lib.types.listOf (lib.types.submoduleWith { modules = [ template ]; });
					readOnly = true;
					default = variants;
				};

			};

		} additionalOptions ]);*/

	};

}
