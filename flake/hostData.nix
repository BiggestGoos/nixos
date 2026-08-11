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
			metaData = (import (./hosts + "/${name}") {}).metaData;

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

				disklessSet.disko.devices = builtins.removeAttrs (set.disko.devices) [ "disk" ];
			in
			if (set != {})
			then
			{
				inherit disklessSet;
				disks = lib.attrsets.mapAttrsToList
				(
					name: value:
						"partitionDisks[\"${value.device}\"]='${builtins.toJSON { "${name}" = value; }}'"
				) set.disko.devices.disk;
			}
			else
			{
				disklessSet = builtins.toJSON {};
				disks = [];
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
	root="$baseRoot${value.root}"
	inputs='${builtins.toJSON value.inputs}'
	partitionsDisklessSet='${builtins.toJSON value.partitioning.disklessSet}'
	declare -A partitionDisks
${lib.strings.concatStringsSep "\n" value.partitioning.disks}
fi
''
	) hosts;

in
''
hostname=$HOSTNAME
baseRoot=$ROOTDIR

${lib.strings.concatStrings setups}
''
