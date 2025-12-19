user:
{ config, lib, ... }:
{

	imports = [
		(import ./disko.nix { root = user.value.home; })
	];

	config.systemd.tmpfiles.settings."${user.value.name}-secondary-drive-permissions" = 
	let
		subvolumes = import ./subvolumes.nix user.value.home;
	in
	lib.attrsets.mapAttrs' (name: value:
	{
		name = value.mountpoint;
		value.z = 
		{
			user = user.value.name;
			group = config.users.users."${user.value.name}".group;
			# Read-write-exec for user, read-exec for group and others. rwx/r-x/r-x.
			# Leading tilde (~), "Optionally, if prefixed with "~", the access mode is masked based on the already set access bits for existing file or directories"
			mode = "~0755";
		};
	}) subvolumes;

}
