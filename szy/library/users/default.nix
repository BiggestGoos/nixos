{ config, options, lib, utils, ... }:
let

	userTypes = config."${options}".users.types.list;

in
{

	mkUser = 
	{ name, userType, shell ? null, extraGroups ? [], homeDirectory ? "/home", homeConfig ? null, configuration ? {}, imports ? [] }:
	let

		isNormalUser = assert (builtins.elem userType userTypes); if (userType == "normal" || userType == "guest") then true else false;

		groups = config."${options}".users.types.groups."${userType}";
		userGroups = config."${options}".users.declared."${name}".groups.extra;

		resolvedShell = if (shell != null) then shell else config.home-manager.users."${name}"."${options}".programs.shell.default.values.package;

		resolvedHomeDirectory = "${homeDirectory}/${name}";

	in
	{
	
		imports = utils.propogateImports {

			inherit name;

			home = resolvedHomeDirectory;

		} imports;
	
		config = {

			users.users."${name}" = {

				isNormalUser = isNormalUser;
				isSystemUser = !isNormalUser;

				extraGroups = groups ++ userGroups ++ extraGroups;

				shell = lib.mkIf (resolvedShell != null) resolvedShell;

				home = resolvedHomeDirectory;

			};

			"${options}".users.homeManagerPaths."${name}".path = lib.mkIf (homeConfig != null) homeConfig;

			home-manager.users."${name}" = {
				
				home = {
					username = name;
					homeDirectory = resolvedHomeDirectory;
				};

			};

		};

		options = {

			"${options}".users.declared."${name}" = {

				type = lib.mkOption {
					type = lib.types.enum userTypes;
					readOnly = true;
					default = userType;
				};

				shell = lib.mkOption {
					type = lib.types.package;
					readOnly = true;
					default = resolvedShell;
				};

				groups = {

					extra = lib.mkOption {
						type = lib.types.listOf lib.types.str;
						default = [];
					};

					resolved = lib.mkOption {
						type = lib.types.listOf lib.types.str;
						readOnly = true;
						default = [ config.users.users."${name}".group ] ++ config.users.users."${name}".extraGroups;
					};

				};

			};

		};

	};

}
