{ lib, config, szy, ... }:
{

	"${szy}".objects.browser =
	{

		data =
		{
			enable = true;
			default.gui.name = "floorp";
		};

		definitions =
		{

			floorp =
			{

				data =
				{

					enable = true;

					components.default.enable = true;

				};

			};

		};

	};

	/*imports = [
		(szy.utils.fromShared "users/user/programs/browser/floorp")
		(szy.utils.fromShared "users/user/programs/browser/librewolf")
	];
	
	"${szy}".programs.browser.default.name = "floorp";*/

}
