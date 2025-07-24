{ ... }:
{

	programs.neovim = {

		enable = true;

		extraConfig = ''
		
			hi Normal ctermbg=none guibg=none

			set number

			set tabstop=4
			set shiftwidth=4

		'';

	};	

}
