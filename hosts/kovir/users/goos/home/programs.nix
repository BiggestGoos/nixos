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
			helix.enable = true;
		};

		fileManager =
		{
			ranger.enable = true;
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
			browser.gui.identifier.name = "floorp";
		};

	};

}
