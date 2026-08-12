{ pkgs, lib, ... }:
let
	url = "github:BiggestGoos/nixos";
	arguments = "--experimental-features 'nix-command flakes'";

	nix = lib.meta.getExe' pkgs.nix "nix";

	run = "${nix} ${arguments} run";

	package =
	pkgs.writeShellScriptBin "updateFlake"
''
url="$1"

if [ -z "$url" ]
then
	url="$FLAKE_URL"
fi
if [ -z "$url" ]
then
	url="${url}"
fi

${run} "$url"#deployFlakeFile
${run} "$url"#generateFlake
'';

in
{

	environment.systemPackages =
	[
		package
	];

}
