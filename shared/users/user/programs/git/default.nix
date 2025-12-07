{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.git;
in
szy.programs.mkInstance
{

	inherit config;
	program = "git";

	values = 
	{
		inherit package;
	};

	configuration =
	{ enabled, ... }:
	lib.mkIf (enabled)
	{

		programs.gh.enable = true;

		programs.git = {
			settings = {
				user = {
					# Add some sort of credential handling or whatever, user specific
					name = "BiggestGoos";
					email = "gustav@fagerlind.net";
				};
				init = {
					defaultBranch = "main";
				};
				safe = {
					directory = szy.utils.rawRoot;
				};
			};
		};
	};

}
