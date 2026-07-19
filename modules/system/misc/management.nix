{ szy, ... }:
let

	path = szy.data.flake.root;

	groupName = "nixmgr";

in
{


	"${szy}".objects.user.data.types.normal.groups = [ groupName ];

	# Maybe think of a better way to do this?

	# Automatically makes directory read-write for members of group 'nixmgr' (Nix Manager).
	systemd.tmpfiles.settings."nixmgr-privileges" = {
	
		# Change mode and owner recursively, Z
		# I would like to set root to 'the root of the flake' but I don't think that is possible as of now (2025-07-22), at least easily.
		"${path}"."Z" = {
			user = "root";
			group = groupName;
			# Read-write-exec for user and group, read-exec for others. rwx/rwx/r-x.
			# Leading tilde (~), "Optionally, if prefixed with "~", the access mode is masked based on the already set access bits for existing file or directories"
			mode = "~0775";
		};	
	
	};

	# Gives users of nixmgr additional rights when using nix
	nix.settings.trusted-users = 
	[
		"@${groupName}"
	];

}
