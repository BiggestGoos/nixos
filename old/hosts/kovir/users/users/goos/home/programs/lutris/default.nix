{ lib, config, szy, ... }:
{

	#"${szy}".objects.gameLauncher.definitions.lutris.data.enable = true;

	/*imports = [
		(szy.utils.fromShared "users/user/programs/lutris")
	];*/

}
