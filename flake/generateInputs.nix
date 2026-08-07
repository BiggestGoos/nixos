{ 
	writeShellScriptBin,
	pkgs, 
	lib, 
	szy,
	... 
}:
let

	sharedFiles = lib.filesystem.listFilesRecursive szy.data.root.modules;

	hostFiles = lib.filesystem.listFilesRecursive szy.data.root.hosts.${szy.data.host.name};

	files = sharedFiles ++ hostFiles;

	flakeFiles =
	builtins.filter
	(
		file:
		let
			fileStr = builtins.toString file;
			isFlakeFile = lib.strings.hasSuffix ".flake" fileStr;
			notUnderscorePrefix = !(lib.strings.hasPrefix "${builtins.dirOf fileStr}/_" fileStr);
		in
			isFlakeFile && notUnderscorePrefix
	) files;

	flakeInputs =
	szy.lib.attrsets.deepMergeList
	(
		builtins.map
		(
			file:
				import file
		) flakeFiles
	);

	string = builtins.toJSON flakeInputs;

in
writeShellScriptBin "generateInputs"
''
${pkgs.coreutils}/bin/echo '${string}' > "${szy.data.flake.root}/flake.inputs"
''
