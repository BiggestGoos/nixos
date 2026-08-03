{
	pkgs,
	lib,
	writeShellScriptBin,
	...
}:
writeShellScriptBin
"reloadFlake"
''
${lib.meta.getExe' pkgs.nix "nix-shell"} https://github.com/vic/flake-file/archive/main.zip -A flake-file.sh --run bootstrap
''
