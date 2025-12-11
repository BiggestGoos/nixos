{ lib, config, szy, ... }:
{

	imports = [
		(szy.utils.fromShared "users/user/programs/browser/floorp")
		(szy.utils.fromShared "users/user/programs/browser/librewolf")
	];
	
	"${szy}".programs.browser.default.name = "floorp";

}
