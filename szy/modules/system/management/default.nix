{ szy, ... }:
let

	path = szy.utils.rawRoot;

in
{

	# In the future, add some sort of thing that adds all users in the 'wheel' group to 'nixmgr' or something like that.
	# Management group for nix(os) configuration
	users.groups.nixmgr = { };

	# Automatically makes directory read-write for members of group 'nixmgr' (Nix Manager).
	systemd.tmpfiles.settings."nixmgr-privileges" = {
	
		# Change mode and owner recursively, Z
		# I would like to set root to 'the root of the flake' but I don't think that is possible as of now (2025-07-22), at least easily.
		"${path}"."Z" = {
			user = "root";
			group = "nixmgr";
			# Read-write-exec for user and group, read-exec for others. rwx/rwx/r-x.
			# Leading tilde (~), "Optionally, if prefixed with "~", the access mode is masked based on the already set access bits for existing file or directories"
			mode = "~0775";
		};	
	
	};

}
