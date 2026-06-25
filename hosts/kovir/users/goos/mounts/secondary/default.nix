{ enabled, final, ... }:
{ config, lib, ... }:
let
	user =
	{
		name = final.data.username;
		group = config.users.users."${user.name}".group;
		home = final.data.homeDirectory;
	};

	disko = import ./disko.nix { root = user.home; };

in
{	
	
	config =
	{

		systemd.tmpfiles.settings."${user.name}-secondary-drive-permissions" = 
		let
			subvolumes = import ./subvolumes.nix user.home;
		in
		enabled.enableIf
		(
			lib.attrsets.mapAttrs' (name: value:
			{
				name = value.mountpoint;
				value.z = 
				{
					user = user.name;
					group = user.group;
					# Read-write-exec for user, read-exec for group and others. rwx/r-x/r-x.
					# Leading tilde (~), "Optionally, if prefixed with "~", the access mode is masked based on the already set access bits for existing file or directories"
					mode = "~0755";
				};
			}) subvolumes
		);

		disko = enabled disko.disko;

	};

}
