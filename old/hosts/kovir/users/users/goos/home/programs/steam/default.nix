{ lib, config, szy, ... }:
{

	"${szy}".objects =
	{
		gameLauncher =
		{
			definitions.steam =
			{
				data.enable = true;
			};
		};
	};

	/*imports = [
		(szy.utils.fromShared "users/user/programs/steam")
	];*/

}
