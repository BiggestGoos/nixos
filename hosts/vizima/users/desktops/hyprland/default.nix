{ szy, pkgs, ... }:
{

	imports = [
		(szy.utils.fromShared "users/desktops/hyprland")
	];

	"${szy}".desktops.desktops.hyprland.styles.enabled = [
		[]
		[ "fallout" ]	
	];

}
