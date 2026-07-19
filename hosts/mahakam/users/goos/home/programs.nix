{ szy, ... }:
{

	"${szy}".catalog.applications =
	{
	
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

		defaults =
		{
			shell.cli.identifier.name = "zsh";
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
