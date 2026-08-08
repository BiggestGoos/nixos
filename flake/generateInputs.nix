{ 
	writeShellScriptBin,
	pkgs, 
	lib, 
	szy,
	... 
}:
let

	getFlakeFiles = directory:
	let
		files = lib.filesystem.listFilesRecursive directory;
	in
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

	inherit (szy.data) root;

	sharedFlakeFiles = getFlakeFiles root.modules;

	hosts' =
	lib.attrsets.filterAttrs
	(
		name: value:
			!(lib.strings.hasPrefix "__" name)
	) root.hosts;

	hosts =
	lib.attrsets.mapAttrs
	(
		name: value:
		let
			metaData = builtins.fromJSON (builtins.readFile value."data.meta");

			flakeFiles = 
			(sharedFlakeFiles) ++
			(getFlakeFiles value);
		in
		{
			inherit (metaData) root;
			inputs =
			szy.lib.attrsets.deepMergeList
			(
				builtins.map
				(
					file:
						import file
				) flakeFiles
			);
		}
	) hosts';

	setups =
	lib.attrsets.mapAttrsToList
	(
		name: value:
''
if [[ "$hostname" == "${name}" ]]
then
	root="${value.root}"
	inputs='${builtins.toJSON value.inputs}'
fi
''
	) hosts;

in
writeShellScriptBin "generateInputs"
''
hostname=$1

if [ -z "$1" ]
then
	hostname=$HOSTNAME
fi

${lib.strings.concatStrings setups}

${pkgs.coreutils}/bin/echo $inputs > $root/flake.inputs
''

/*let

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
''*/
