{ szy, desktop, ... }:
{

	imports = [
		(szy.utils.fromShared "users/user/desktops/hyprland")
	];

}
