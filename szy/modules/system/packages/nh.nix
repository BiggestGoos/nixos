{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "package";

	name = "nh";

	additionalParameters =
	{

		clean = {

			enable = lib.mkOption {
				type = lib.types.bool;
				default = false;
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

	configuration = 
	{ enabled, final, template }:
	{

		programs.nh =
		{

			enable = true;
			flake = szy.utils.rawRoot;

			clean =
			let
				cfg = final.data.clean;
			in
			{

				enable = cfg.enable;
				dates = cfg.dates;

				extraArgs = "--keep ${builtins.toString cfg.generations.numberToKeep} --keep-since ${cfg.generations.keepSince} ${if (cfg.optimise) then "--optimise" else ""}";

			};
		};

	};

}

