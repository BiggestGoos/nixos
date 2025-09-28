{ pkgs, lib, config, szy, ... }:
{

	imports = [
		./goos
	];

	options."${szy}".users = {

		available = lib.mkOption {
			type = lib.types.listOf lib.types.str;
			readOnly = true;
			default = builtins.attrNames config.users.users;
		};

		default = lib.mkOption {
			type = lib.types.enum config."${szy}".users.available;
			default = "root";
		};

	};

	config = {

		"${szy}".users.default = "goos";

	};

}
