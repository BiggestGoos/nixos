{ szy, config, pkgs, ... }:
{
/*
	hardware.i2c.enable = true;

	boot.extraModulePackages = [ config.boot.kernelPackages.ddcci-driver ];
	boot.kernelModules = [ "i2c-dev" "ddcci_backlight" ];

	services.ddccontrol = {

		enable = true;
		package = pkgs.ddcutil-service;

	};
*/

	"${szy}".users.types.groups.normal = [ "video" ];

}
