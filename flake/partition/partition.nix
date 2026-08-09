let
	merge = lhs: rhs: lhs // rhs;

	mergeSets = list: builtins.foldl' merge {} list;

	partitionsDirectory = "partitions";

	files' = builtins.readDir ./${partitionsDirectory};
	files = builtins.map
	(
		name:
			./${partitionsDirectory} + "/${name}"
	) (builtins.attrNames files');

	sets = builtins.map
	(
		file:
			builtins.fromJSON (builtins.readFile file)
	) files;

	disksSet = mergeSets sets;
	
	diskless = builtins.fromJSON (builtins.readFile ./diskless);

	merged.disko = diskless.disko //
	{
		devices = diskless.disko.devices // 
		{
			disk = disksSet;
		};
	};
in
	merged
