{ lib, config, szy, ... }:
{

	imports = [
		(szy.utils.fromShared "users/user/programs/nh")
	];

}
