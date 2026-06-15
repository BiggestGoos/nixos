{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "editor";

	name = "neovim";

	arguments = 
	{ final, template }:
	{

		application.type = "cli";

	};

	configuration = 
	{ enabled, final, template }:
	{

		programs.neovim = {

			enable = true;

			defaultEditor = template.data.default.cli.identifier == final.meta.identifier;

		};	

	};

}

