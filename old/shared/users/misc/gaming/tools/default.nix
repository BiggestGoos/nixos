enabled:
{ szy, lib, pkgs, ... }:
enabled
{

	programs = {
		gamescope.enable = true;
		gamemode = {

			enable = true;

		};
	};

	"${szy}".users.types.groups.normal = [ "gamemode" ];

}
