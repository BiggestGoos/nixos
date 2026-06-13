{ lib, config, szy, ... }:
{

	"${szy}".objects =
	{
		gaming.data.enable = true;
		gameLauncher =
		{
			data.enable = true;
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
