{ pkgs, lib, config, szy, ... }:
{

	imports = [
		./goos
	];

	options."${szy}".users = {

		default = lib.mkOption {
			type = 
			let
				available = builtins.attrNames config.users.users;
			in
				lib.types.enum available;
			default = "root";
		};

	};

	config = {

		"${szy}".users.default = "goos";

	};

}
