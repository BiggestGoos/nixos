{ lib, config, szy, ... }:
{

	"${szy}".objects =
	{
		gaming.data.enable = true;
		application.definitions.steam =
		{
			data.enable = true;
		};
		package.definitions =
		{
			gamescope.data.enable = true;
			gamemode.data.enable = true;
		};
	};

	/*imports = [
		(szy.utils.fromShared "users/programs/steam")
	];*/

}
