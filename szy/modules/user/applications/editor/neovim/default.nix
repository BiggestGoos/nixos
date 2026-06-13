{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "editor";
	extends = [ "terminalApplication" ];

	name = "neovim";

	arguments = 
	{ final, object }:
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
	{ enabled, final, object }:
	{

		

		programs.neovim = {

			enable = true;

			extraConfig = ''
		
				hi Normal ctermbg=none guibg=none

				set number

				set tabstop=4
				set shiftwidth=4

			'';

			defaultEditor = { inherit (object.data.default.cli) name template; } == { inherit (final.meta) name template; };

		};

	};

}

