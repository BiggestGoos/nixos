{ szy, lib, config, ... }:
{

	imports = [
		(import (szy.utils.fromShared "internal/shared/programs/nh") 
		({ enabled, optionKeys, ... }:
		let

			cfg = (lib.attrsets.getAttrFromPath optionKeys config."${szy}").clean;

		in
		{ 
			
			options."${szy}" = lib.attrsets.setAttrByPath optionKeys {
				
				clean = {

					enable = lib.mkOption {
						type = lib.types.bool;
						default = true;
					};

					generations = {

						numberToKeep = lib.mkOption {
							type = lib.types.ints.positive;
							default = 5;
						};

						keepSince = lib.mkOption {
							type = lib.types.str;
							default = "3d";
						};

					};

					optimise = lib.mkOption {
						type = lib.types.bool;
						default = true;
					};

					dates = lib.mkOption {
						type = lib.types.str;
						default = "weekly";
					};

				};

			};

			config.programs.nh.clean = lib.mkIf (enabled) {

				enable = cfg.enable;
				dates = cfg.dates;

				extraArgs = "--keep ${builtins.toString cfg.generations.numberToKeep} --keep-since ${cfg.generations.keepSince} ${if (cfg.optimise) then "--optimise" else ""}";

			};

		}))
	];

}
