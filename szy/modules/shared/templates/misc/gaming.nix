{ szy, lib, config, pkgs, systemConfig, ... }:
szy.objects.declare
{

	inherit config;
	
	name = "gaming";

	configuration =
	{ enabled, final }:
	if (systemConfig)
	then
	{

		boot.kernel.sysctl."vm.max_map_count" = 2147483642;

	}
	else
	{

		

	};

}
