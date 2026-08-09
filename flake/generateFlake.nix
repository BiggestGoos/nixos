{ 
	writeShellScriptBin,
	pkgs, 
	lib,
	hostData,
	generateInputs,
	... 
}:
writeShellScriptBin "generateFlake"
(
	hostData +
''
${lib.meta.getExe generateInputs}
cd $root
${lib.meta.getExe' pkgs.nix "nix-shell"} https://github.com/denful/flake-file/archive/main.zip -A flake-file.sh --run bootstrap
''
)
