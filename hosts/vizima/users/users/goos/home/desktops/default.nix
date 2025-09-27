{ osConfig, szy, ... }:
{
	
	imports = [
		(import (szy.utils.fromShared "users/user/desktops") ./.)
	];

}
