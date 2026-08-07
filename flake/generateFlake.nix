{ 
	writeShellScriptBin,
	pkgs, 
	lib,
	szy,
	... 
}@inputs:
let
	generateInputs = pkgs.callPackage ./generateInputs.nix inputs;
in
writeShellScriptBin "generateFlake"
''
cd "${szy.data.flake.root}"
${lib.meta.getExe generateInputs}
${lib.meta.getExe' pkgs.nix "nix-shell"} https://github.com/denful/flake-file/archive/main.zip -A flake-file.sh --run bootstrap
''
