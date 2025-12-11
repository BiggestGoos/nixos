{ szy, pkgs, config, ... }:
szy.users.mkUser
{

	name = "goos";
	userType = "normal";

	homeConfig = ./home;

}
