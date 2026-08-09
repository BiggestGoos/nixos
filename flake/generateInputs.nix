{ 
	writeShellScriptBin,
	pkgs,
	hostData,
	... 
}:
writeShellScriptBin "generateInputs"
(
	hostData +
''
${pkgs.coreutils}/bin/echo $inputs > $root/flake.inputs
''
)
