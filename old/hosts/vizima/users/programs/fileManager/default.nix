{ lib, config, szy, ... }:
{

	imports = [
		(szy.utils.fromShared "users/programs/fileManager/yazi")
	];

}
