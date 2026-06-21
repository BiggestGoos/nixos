{ lib, config, szy, ... }:
{

	"${szy}".objects.terminal =
	{

		data =
		{
			default.gui.identifier.name = "kitty";
		};

		definitions =
		{
			kitty.data =
			{
				enable = true;
			};
			ghostty.data.enable = true;
		};

	};

/*	imports = [
		(szy.utils.fromShared "users/user/programs/terminal/kitty")
	];*/

}
