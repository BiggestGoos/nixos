{ lib, config, pkgs, ... }:
{

	options.profiles = {

		base.branches = lib.mkOption {

			type = 
			let
				template = {

					options.branches = lib.mkOption {
						type = lib.types.attrsOf (lib.types.submoduleWith { modules = [ template ]; });	
						default = { };
					};

					options.configuration = lib.mkOption {
						type = lib.types.attrs;
						default = { };
					};

					options.resolveTo = lib.mkOption {
						type = lib.types.bool;
						default = false;
					};

				};
			in
				lib.types.attrsOf (lib.types.submoduleWith { modules = [ template ]; });

		};

		resolved = lib.mkOption {

			type = lib.types.listOf (lib.types.listOf lib.types.attrs);
			readOnly = true;

			default = 
			let
				flattenTree = import ./flattenTree.nix;
			in
				(flattenTree config.profiles.base);

		};

		available = lib.mkOption {
			type = lib.types.listOf lib.types.str;
			readOnly = true;

			default = 
			let
				result = (builtins.map (profile: (builtins.concatStringsSep "-" (builtins.map (branch: branch.name) profile))) config.profiles.resolved);
			in
				result;

		};

		default = lib.mkOption {
			type = lib.types.nullOr (lib.types.enum (config.profiles.available));
			default = null;
		};

		enabled = lib.mkOption {
			type = lib.types.nullOr (lib.types.listOf lib.types.str);
			default = null;
		};

		test = lib.mkOption {
			
			type = lib.types.attrs;

		};

	};

	config = {

		specialisation = (builtins.listToAttrs (builtins.map (
		profile: 
		let

			name = (builtins.concatStringsSep "-" (builtins.map (branch: branch.name) profile));
			value.configuration = 
			{ 

				environment.etc."specialisation".text = name;

				profiles.default = name;
				profiles.enabled = (builtins.map (branch: branch.name) profile);
				
				imports = (builtins.map (branch: branch.configuration) profile);

			};

		in
			{
				inherit name value;
			}
		) config.profiles.resolved));

		#Make agnostic to bootloader.
		boot.loader.systemd-boot.extraInstallCommands = 
		let
			boot_dir = config.boot.loader.efi.efiSysMountPoint;
			config_path = boot_dir + "/loader/loader.conf";

			default = config.profiles.default;
			bootName = if (builtins.isNull default) then "$(</etc/specialisation)" else default;
		in
		''
			if [ "${bootName}" == "" ]; then
				current_profile=""
			else
				current_profile="-specialisation-${bootName}"
			fi
			
			${pkgs.gnused}/bin/sed -i -E "s/default nixos-generation-([0-9]+).*\.conf/default nixos-generation-\1$current_profile.conf/" ${config_path}
		'';

		assertions = [
			{
				assertion = config.boot.loader.systemd-boot.enable;
				message = "At the moment systemd-boot is the only bootloader that I have set up automatic boot entry for profiles, use systemd-boot or add new bootloader!";
			}
		];

	};

}
