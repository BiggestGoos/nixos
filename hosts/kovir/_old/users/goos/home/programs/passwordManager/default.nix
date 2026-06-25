{ lib, config, szy, ... }:
{

	"${szy}".objects.application.definitions.bitwarden.data.enable = true;

	/*imports = [
		(szy.utils.fromShared "users/user/programs/passwordManager/bitwarden")
	];*/

}
