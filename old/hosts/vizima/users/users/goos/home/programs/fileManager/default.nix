{ lib, config, szy, ... }:
{

	imports = [
		(szy.utils.fromShared "users/user/programs/fileManager/yazi")
		(szy.utils.fromShared "users/user/programs/fileManager/nemo")
	];

}
