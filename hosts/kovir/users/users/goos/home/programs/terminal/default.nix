{ lib, config, szy, ... }:
{

	"${szy}".objects.terminal =
	{

		data =
		{

			enable = true;
			default.gui.name = "kitty";

		};

		definitions.kitty.data =
		{
			enable = true;
		};

	};

/*	imports = [
		(szy.utils.fromShared "users/user/programs/terminal/kitty")
	];*/

}
