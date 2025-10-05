{ options, lib, utils, ... }:
{

	mkVarying = { path, config, option, variants, defaultVariants ? [], configuration ? {}, additionalOptions ? {}, additionalData ? {} }:
	let
		keyNames = [ options ] ++ option;
	in
	{

		imports = builtins.map (variant: ((import (path + ("/" + variant)) (
		(utils.mergeAll [ ({
			name = variant;
			__toString = self: self.name;
			enabled = (builtins.elem variant (lib.attrsets.getAttrFromPath (keyNames ++ [ "enabledVariants" ]) config));
		}) additionalData ])
		)))) variants;

		options = (utils.mergeAll [ (lib.attrsets.setAttrByPath keyNames ({

			availableVariants = lib.mkOption {
				type = lib.types.listOf lib.types.str;
				default = variants;
				readOnly = true;
			};

			enabledVariants = lib.mkOption {
				type = lib.types.listOf (lib.types.enum variants);
				default = defaultVariants;
			};

		})) additionalOptions ]);

		config = configuration;

	};

}
