{ ... }:
{

	# https://wiki.nixos.org/wiki/Laptop

	services.thermald.enable = true;

	services.auto-cpufreq = {

		enable = false;

		settings = {

			battery = {
    				governor = "powersave";
				energy_performance_preference = "balance_power";
				turbo = "never";
			};

			charger = {
    				governor = "performance";
				energy_performance_preference = "performance";
    				turbo = "auto";
  			};

		};

	};

}
