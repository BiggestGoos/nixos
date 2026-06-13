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

				innerModule = lib.types.submoduleWith { modules = [ (
				{ config, ... }:
				{

					options =
					{

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

				} ) ]; };

				treeType = 
				let
					leafOrBranch = lib.types.oneOf 
					[
        				(typecheckSubmoduleByTryEval innerModule)
						(lib.types.attrsOf leafOrBranch)
          			];
        		in 
					leafOrBranch;

			in
				lib.types.attrsOf treeType;
		};

	};

}
