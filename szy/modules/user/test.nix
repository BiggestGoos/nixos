{ szy, lib, config, ... }:
{

	options."${szy}".test =
	{

		nested = lib.options.mkOption
		{
			type = 
			let

				# https://discourse.nixos.org/t/problems-with-types-oneof-and-submodules/15197/5
				typecheckSubmoduleByTryEval = submodule: 
				let
					check = x: 
					(
						builtins.tryEval 
						(
							(
								lib.evalModules 
								{
									modules = submodule.getSubModules ++ [ x ];
								}
							).config
						)
					).success;
				in 
					lib.types.addCheck submodule check;

				testModule = 
				{ config, ... }:
				{
					options = 
					{
						meta = lib.options.mkOption
						{
							type = lib.types.attrs;
							default = {};
						};

						x = lib.options.mkOption
						{
							type = lib.types.int;
							default = 5;
						};
					};
				};

				test2Module =
				{ config, ... }:
				{
					options = 
					{
						/*data.y = lib.options.mkOption
						{
							type = lib.types.int;
							default = config.data.x * 2;
						};*/

						y = lib.options.mkOption
						{
							type = lib.types.int;
							default = config.x * 2 + 25;
						};

						/*xy = lib.options.mkOption
						{
							type = lib.types.int;
							default = config.data.x * config.y;
						};*/
					};
				};

				allModules =
				{
					inherit testModule test2Module;
				};

				innerModule = lib.types.submoduleWith { modules = [ (
				{ config, ... }:
				let

					freeModules = builtins.map (module: allModules."${module}") config.meta.modules;

					eval = lib.modules.evalModules 
					{
						modules = freeModules;
					};

				in
				{
	
					#freeformType = (lib.types.submoduleWith { modules = freeModules; });

					options =
					{

						meta.modules = lib.options.mkOption
						{
							type = lib.types.listOf lib.types.str;
							default = [ "testModule" ];
						};

						#test = lib.options;

						data = lib.options.mkOption
						{
							type = lib.types.submoduleWith { modules = freeModules; };
							default = {};
						};

						/*tree = lib.options.mkOption
						{
							type = lib.types.nullOr treeType;
							default = null;
						};*/

						str = lib.options.mkOption
						{
							type = lib.types.str;
						};

						int = lib.options.mkOption
						{
							type = lib.types.int;
							default = 5;
						};

						str2 = lib.options.mkOption
						{
							type = lib.types.str;
							default = "${config.str}+${builtins.toString config.int}";
						};

					};

					config = 
					{
						meta = lib.mkDefault {};
					};

				} ) ]; };

				treeType = mkTreeType [ innerModule ];

				mkTreeType = modules:
				let
					leafOrBranch = lib.types.oneOf 
					((builtins.map (module: typecheckSubmoduleByTryEval module) modules) ++
					[
						(lib.types.attrsOf leafOrBranch)
          			]);
        		in 
					leafOrBranch;

			in
				lib.types.attrsOf treeType;
		};

	};

}
