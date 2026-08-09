{ 
	writeShellScriptBin,
	pkgs,
	hostData,
	... 
}:
let
	flakesDataDirectory = ./hosts;
in
writeShellScriptBin "deployFlake"
(
	hostData +
''
hostDataPath="${flakesDataDirectory}/"$hostname""
flakeTemplate="$(<"${./flakeTemplate.nix.pseudo}")"
hostData="$(<"$hostDataPath")"

withHostname="''${flakeTemplate/"%HOSTNAME%"/"\"$hostname\""}"
finalFlake="''${withHostname/"%DATA%"/"$hostData"}"

${pkgs.coreutils}/bin/mkdir -p "$root"
${pkgs.coreutils}/bin/echo "$finalFlake" > "$root/flake-file.nix"
''
)
