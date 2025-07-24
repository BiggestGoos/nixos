{ pkgs, ... }:
{

	imports = [
		./shells
		./editors
		./gaming
	];

	environment.systemPackages = [
		pkgs.git
		pkgs.gh
	];

}
