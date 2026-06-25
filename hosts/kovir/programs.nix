{ szy, lib, config, pkgs, ... }:
{

	"${szy}".catalog =
	{

		applications =
		{

			steam.enable = true;		
			editor.neovim.enable = true;
			shell.zsh.enable = true;
			fileManager.yazi.enable = true;

			defaults =
			{

				editor.cli.identifier.name = "neovim";
				shell.cli.identifier.name = "zsh";
				fileManager.cli.identifier.name = "yazi";

			};

		};

	};

}
