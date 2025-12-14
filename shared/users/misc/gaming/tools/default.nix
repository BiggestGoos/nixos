enabled:
{ szy, lib, pkgs, ... }:
lib.mkIf (enabled)
{

	programs = {
		gamescope.enable = true;
		gamemode = {

			enable = true;

		};
	};

	"${szy}".users.types.groups.normal = [ "gamemode" ];

}
