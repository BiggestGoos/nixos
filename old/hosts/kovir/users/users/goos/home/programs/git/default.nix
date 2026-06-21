{ lib, config, szy, ... }:
{

	"${szy}".objects.package.definitions.git.data.enable = true;

	/*imports = [
		(szy.utils.fromShared "users/user/programs/git")
	];*/

}
