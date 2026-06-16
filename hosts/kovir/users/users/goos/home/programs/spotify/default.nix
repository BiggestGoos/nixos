{ lib, config, szy, ... }:
{

	"${szy}".objects.musicPlayer.definitions.spotify.data.enable = true;

	/*imports = [
		(szy.utils.fromShared "users/user/programs/musicPlayer/spotify")
	];*/

}
