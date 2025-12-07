enabled:
{ lib, ... }:
lib.mkIf (enabled)
{

	programs = {
		gamescope.enable = true;
		gamemode.enable = true;
	};

}
