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
		application.type = "cli";
		application.terminal.name = "kitty";

		desktopEntry =
		{

			base.path = "nvim";

		};
	};

	configuration = 
	enabled:
	{ final, object }:
	enabled
	{

		

		programs.neovim = {

			enable = true;

			extraConfig = ''
		
				hi Normal ctermbg=none guibg=none

				set number

				set tabstop=4
				set shiftwidth=4

			'';

			defaultEditor = object.data.default.cli == { inherit (final.meta) name template; };

		};

	};

}

