enabled:
{ lib, pkgs, ... }:
enabled
{

	home.packages = [
		pkgs.protonup-qt
	];

	programs.mangohud = {

		enable = true;

		settings = {
			no_display = true;

			gpu_temp = true;
			cpu_temp = true;
		};

	};

}
