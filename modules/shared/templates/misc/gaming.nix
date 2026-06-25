{ szy, lib, config, pkgs, ... }@moduleInput:
(szy config).objects.declare
{
	
	name = "gaming";

	configuration =
	{ enabled, final }:
	if (szy.data.configType == "system")
	then
	{

		boot.kernel.sysctl."vm.max_map_count" = 2147483642;

		"${szy}".objects.user.data.types.gaming = {};

	}
	else if (szy.data.configType == "user")
	then
	let
		systemFinal = szy.objects.utils.template.get { config = moduleInput.osConfig; meta = final.meta; };
	in
	{

		warnings =
		[
			(lib.mkIf (systemFinal.data.enable == false) "Gaming is enabled in user configuration but not in system, there are certain optimizations that can only be enabled at system level.")
		];

	}
	else
	{};

}
