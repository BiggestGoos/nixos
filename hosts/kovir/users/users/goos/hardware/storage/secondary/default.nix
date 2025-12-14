user:
{ config, lib, ... }:
{

	imports = [
		(import ./disko.nix { root = user.home; })
	];

	options.test = lib.mkOption {
		type = lib.types.attrs;
		default = user;
	};	

	config.systemd.tmpfiles.settings."${user.name}-secondary-drive-permissions" = 
	let
		subvolumes = import ./subvolumes.nix user.home;
	in
	lib.attrsets.mapAttrs' (name: value:
	{
		name = value.mountpoint;
		value.z = 
		{
			user = user.name;
			group = config.users.users."${user.name}".group;
			# Read-write-exec for user, read-exec for group and others. rwx/r-x/r-x.
			# Leading tilde (~), "Optionally, if prefixed with "~", the access mode is masked based on the already set access bits for existing file or directories"
			mode = "~0755";
		};
	}) subvolumes;

}
