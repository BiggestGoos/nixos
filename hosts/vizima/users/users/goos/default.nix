{ szy, pkgs, config, ... }:
szy.users.mkUser
{

	name = "goos";
	userType = "normal";

	# Should be added instead by respective declarer to 'normal' user-type groups
	extraGroups = [
		"networkmanager"
		"nixmgr"
		"gamemode"
		"video"
	];

	homeConfig = ./home;

}
