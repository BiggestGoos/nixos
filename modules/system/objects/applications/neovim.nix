{ szy, lib, config, pkgs, ... }:
(szy config).objects.define
{

	template = "editor";

	name = "neovim";

	arguments = 
	{

		application.type = "cli";

	};

	configuration = 
	{ enabled, final, template }:
	{

		programs.neovim = {

			enable = true;

			defaultEditor = final.meta.identifier == template.data.default.cli.identifier;

		};	

	};

}

