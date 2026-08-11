{ 
	writeShellScriptBin,
	pkgs,
	hostData,
	... 
}:
let
	flakesDataDirectory = ./hosts;
in
writeShellScriptBin "deployFlakeFile"
(
	hostData +
''
hostDataFile="${flakesDataDirectory}/"$hostname""
flakeFile="${./flake-file.nix}"

${pkgs.coreutils}/bin/mkdir -p "$root"

${pkgs.coreutils}/bin/printf "%s" \""$hostname"\" | ${pkgs.coreutils}/bin/install --mode=660 /dev/stdin "$root/hostname.nix"

${pkgs.coreutils}/bin/install --mode=660 $hostDataFile "$root/data.nix"

${pkgs.coreutils}/bin/install --mode=660 $flakeFile "$root/flake-file.nix"
''
)
