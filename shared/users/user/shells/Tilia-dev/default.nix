{ szy, pkgs, ... }:
{

	home.packages = [
		(pkgs.writeShellScriptBin "Tilia-dev" "exec nix develop ${szy.utils.rawRoot + "/shared/users/user/shells/Tilia-dev/shell#Tilia-dev"}")
	];

}
