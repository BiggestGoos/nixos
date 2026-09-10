{ szy, lib, config, pkgs, ... }:
(szy config).objects.make
{
	inherits = [ [ "programs" "editor" ] ];
	#extends = [ "terminalApplication" ];

	name = "neovim";
	namespace = [ "programs" ];

	constant.type = "cli";

	variable = 
	{
		entry =
		{

			default =
			{
				base.locator = "nvim";
			};

		};
	};

	output.config = 
	{

		programs.neovim = 
		{

			enable = true;

			extraConfig = ''
		
				hi Normal ctermbg=none guibg=none

				set number

				set tabstop=4
				set shiftwidth=4

			'';	
		};

	};

}

