{ pkgs, ... }:
{

	services.printing.enable = true;
	services.printing.drivers = [ pkgs.hplip ];

	environment.systemPackages = [
		pkgs.system-config-printer
	];

	services.avahi = {
		enable = true;
		nssmdns4 = true;
		openFirewall = true;
	};

}
