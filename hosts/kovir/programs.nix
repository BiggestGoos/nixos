{ szy, lib, config, pkgs, ... }:
{

	"${szy}".catalog =
	{

		programs =
		{

			steam.enable = true;		
			neovim.enable = true;
			zsh.enable = true;
			yazi.enable = true;
			nh.enable = true;

			default =
			{

				editor.cli = "neovim";
				shell.cli = "zsh";
				fileManager.cli = "yazi";

			};

		};

	};

}
