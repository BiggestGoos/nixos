{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "editor";
	extends = [ "terminalApplication" ];

	name = "neovim";

	arguments = 
	{ final, template }:
	{
		desktopEntry =
		{

			default =
			{
				base.path = "nvim";
				overrides.desktopName = "Neovim";
			};

		};
	};

	configuration = 
	{ enabled, final, template }:
	{

		

		programs.neovim = {

			enable = true;

			extraConfig = ''
		
				hi Normal ctermbg=none guibg=none

				set number

				set tabstop=4
				set shiftwidth=4

			'';

			defaultEditor = template.data.default.cli.identifier == final.meta.identifier;

		};

	};

}

