{ szy, lib, config, pkgs, ... }:
(szy config).objects.make
{

	inherits = [ "program" ];

	name = "git";
	namespace = [ "programs" ];

	output.config = 
	{

		programs.gh.enable = true; # TODO: Split into different package or, maybe create new template that fits better

		programs.git = 
		{
			enable = true;
			settings = 
			{
				user = 
				{
					# TODO: Add some sort of credential handling or whatever, user specific
					name = "BiggestGoos";
					email = "gustav@fagerlind.net";
				};
				init = 
				{
					defaultBranch = "main";
				};
				safe = 
				{
					directory = szy.data.flake.root + "/*";
				};
			};
		};

	};

}

