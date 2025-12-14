{ szy, pkgs, config, ... }:
szy.users.mkUser
rec {

	name = "goos";
	userType = "normal";

	homeConfig = ./home;

	imports = [
		./hardware
	];

}
