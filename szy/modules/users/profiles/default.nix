{ lib, config, pkgs, szy, ... }:
{

	options."${szy}".profiles = {

		base.branches = lib.mkOption {

			type = 
			let
				template.options = {

					branches = lib.mkOption {
						type = lib.types.attrsOf (lib.types.submoduleWith { modules = [ template ]; });	
						default = { };
					};

					configuration = lib.mkOption {
						type = lib.types.attrs;
						default = { };
					};

					globalConfiguration = lib.mkOption {
						type = lib.types.attrs;
						default = { };
					};

					resolveTo = lib.mkOption {
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

			default = (szy.profiles.flattenTree config."${szy}".profiles.base);

		};

		available = lib.mkOption {
			type = lib.types.listOf lib.types.str;
			readOnly = true;

			default = 
			let
				result = (builtins.map (profile: (builtins.concatStringsSep "-" (builtins.map (branch: branch.name) profile))) config."${szy}".profiles.resolved);
			in
				result;

		};

		enabled = lib.mkOption {
			type = lib.types.nullOr (lib.types.enum (config."${szy}".profiles.available));
			default = null;
		};

	};

	config = {

		specialisation = 
		let
			resolved = config."${szy}".profiles.resolved;
			globalConfiguration = szy.utils.mergeAll (builtins.map (profile: profile.globalConfiguration) (lib.lists.flatten resolved));
		in
		(builtins.listToAttrs (builtins.map (
		profile: 
		let

			name = (builtins.concatStringsSep "-" (builtins.map (branch: branch.name) profile));
			value.configuration = 
			{ 

				environment.etc."specialisation".text = name;

				"${szy}".profiles = {
					
					enabled = name;

				};
				
				imports = [ globalConfiguration ] ++ (builtins.map (branch: branch.configuration) profile);

			};

		in
			{
				inherit name value;
			}
		) resolved));

		#Make agnostic to bootloader.
		boot.loader.systemd-boot.extraInstallCommands = 
		let
			boot_dir = config.boot.loader.efi.efiSysMountPoint;
			config_path = boot_dir + "/loader/loader.conf";

			default = config."${szy}".profiles.enabled;
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
