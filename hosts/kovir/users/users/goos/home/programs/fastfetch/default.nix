{ lib, config, szy, ... }:
{

	"${szy}".objects.package.definitions.fastfetch.data.enable = true;

	/*imports = [
		(szy.utils.fromShared "users/user/programs/fastfetch")
	];*/

}
