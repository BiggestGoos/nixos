{ lib, config, szy, ... }:
{

	imports = [
		./floorp
		./librewolf
		(szy.utils.fromShared "users/user/programs/browsers")
	];
	
	"${szy}".browsers = {

		default = "floorp";

	};

}
