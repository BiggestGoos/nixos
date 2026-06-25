{ szy, ... }:
{

	"${szy}".catalog.applications =
	{

		anki.enable = true;
		discord.enable = true;

		browser =
		{
			floorp.enable = true;
		};

		editor =
		{
			neovim.enable = true;
			helix.enable = true;
		};

		fileManager =
		{
			yazi.enable = true;
			ranger.enable = true;
		};

		shell =
		{
			zsh.enable = true;
		};

		gameLauncher =
		{
			steam.enable = true;
		};

		terminal =
		{
			kitty.enable = true;
		};

		defaults =
		{
			shell.cli.identifier.name = "zsh";
			browser.gui.identifier.name = "floorp";
			editor =
			{
				cli.identifier.name = "neovim";
				any.identifier.name = "neovim";
			};
			fileManager =
			{
				cli.identifier.name = "yazi";
				any.identifier.name = "yazi";
			};
		};

	};

}
