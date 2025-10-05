{ szy, pkgs, ... }:
{

	imports = [
		./shells
		./editors
		./gaming
		(szy.utils.fromShared "users/programs/preload")
	];

	environment.systemPackages = [
		pkgs.git
		pkgs.gh
	];

}
