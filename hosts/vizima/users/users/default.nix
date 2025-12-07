{ pkgs, lib, config, szy, ... }:
{

	imports = [
		./goos
	];
	
	config = {

		"${szy}".users.default.name = "goos";

	};

}
