{ osConfig, szy, config, ... }:
{
	
	imports = [
		(import (szy.utils.fromShared "users/user/desktops") ./. {

		})
	];

}
