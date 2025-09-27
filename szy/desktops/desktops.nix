{ config, lib, options, utils }:
rec {
	
	mkDesktop = { name, enabled ? [], imports ? [], configuration ? { ... }: {}, additionalOptions ? {} }:
	{
		options = (utils.mergeAll [ ({

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

			};

		}) additionalOptions ]);

	};

}
