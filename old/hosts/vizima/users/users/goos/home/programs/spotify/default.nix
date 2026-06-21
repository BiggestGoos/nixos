{ lib, config, szy, ... }:
{

	imports = [
		(szy.utils.fromShared "users/user/programs/musicPlayer/spotify")
	];

}
