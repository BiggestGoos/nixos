{ 
	writeShellScriptBin,
	pkgs, 
	szy,
	lib,
	... 
}@inputs:
writeShellScriptBin "updateFlakeInputs"
''
cd "${szy.data.flake.root}"
${lib.meta.getExe' pkgs.nix "nix"} flake update flake
(${lib.meta.getExe' pkgs.nix "nix"} run ./#generateFlake) || (generateFlake)
''
