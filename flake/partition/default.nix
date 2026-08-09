{ 
	writeShellScriptBin,
	pkgs,
	lib,
	hostData,
	... 
}:
let
	directory = "/tmp/partitioning";
	partitionsDirectory = "${directory}/partitions";

	disklessPath = "${directory}/diskless";

	install = "${lib.meta.getExe' pkgs.coreutils "install"} -D --mode=666";
	echo = lib.getExe' pkgs.coreutils "echo";
in
writeShellScriptBin "partition"
(
	hostData +
''
${lib.getExe' pkgs.coreutils "rm"} -rf ${directory}

${lib.getExe' pkgs.coreutils "mkdir"} -p ${directory}

${echo} "$partitionsDisklessSet" > "${disklessPath}"
${lib.getExe' pkgs.coreutils "chmod"} 666 "${disklessPath}"

${install} ${./partition.nix} ${directory}/partition.nix

${lib.getExe' pkgs.coreutils "mkdir"} -p ${partitionsDirectory}
for key in ''${!partitionDisks[@]}; do

	${echo} "Do you want to partition device \"$key\"? yes/no=!(yes)"
	read answer

	if [ "$answer" != "yes" ]
	then
		${echo} "Will NOT partition \"$key\"!"
		continue
	fi

	${echo} "##### Will partition \"$key\"!"

	name="$(${lib.getExe' pkgs.coreutils "basename"} ''${key})"
	path=${partitionsDirectory}/$name
    ${echo} ''${partitionDisks[''${key}]} > "$path"
	${lib.getExe' pkgs.coreutils "chmod"} 666 "$path"
done

${lib.getExe' pkgs.nix "nix"} --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ${directory}/partition.nix
''
)
