{ lib, config, szy, ... }:
{

	"${szy}".objects.application.definitions.discord.data.enable = true;

	/*imports = [
		(szy.utils.fromShared "users/user/programs/discord")
	];*/

}
