{
	lib, 
	szy,
	... 
}:
let

	getFiles = suffix: directory:
	let
		files = lib.filesystem.listFilesRecursive directory;
	in
	builtins.filter
	(
		file:
		let
			fileStr = builtins.toString file;
			isFileType = lib.strings.hasSuffix suffix fileStr;
			notUnderscorePrefix = !(lib.strings.hasPrefix "${builtins.dirOf fileStr}/_" fileStr);
		in
			isFileType && notUnderscorePrefix
	) files;

	getFlakeFiles = getFiles ".flake";

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
			partitioning =
			let
				diskoFiles = getFiles ".nix.disko" value;
				set = 
				szy.lib.attrsets.deepMergeList
				(
					builtins.map
					(
						file:
							import file
					) diskoFiles
				);

				disklessSet.disko.devices = builtins.removeAttrs set.disko.devices [ "disk" ];
			in
			{
				inherit disklessSet;
				disks = 
			};
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
	partitionsFile="{ }"
fi
''
	) hosts;

in
''
hostname=$1

if [ -z "$1" ]
then
	hostname=$HOSTNAME
fi

${lib.strings.concatStrings setups}
''
