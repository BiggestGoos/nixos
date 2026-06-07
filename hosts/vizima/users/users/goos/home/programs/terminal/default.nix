{ lib, config, szy, ... }:
{

	"${szy}".objects.terminal =
	{

		data =
		{
	
			enable = true;
			default.gui.name = "ghostty";

		};

		definitions =
		{
			kitty.data.enable = true;
			ghostty.data.enable = true;
		};

	};

}
