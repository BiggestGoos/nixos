{ szy, lib, config, pkgs, ... }@moduleInput:
(szy config).objects.make.template
{
	
	name = "gaming";

	output.config =
	{ variable, meta, ... }:
	if (szy.data.configType == "system")
	then
	{

		boot.kernel.sysctl."vm.max_map_count" = 2147483642;

		"${szy}".users.types.gaming = {};

	}
	else if (szy.data.configType == "user")
	then
	let
		system = szy.objects.utils.get { config = moduleInput.osConfig; inherit (meta) identifier; };
	in
	{

		warnings =
		[
			(lib.mkIf (system.constant.enabled == false) "Gaming is enabled in user configuration but not in system, there are certain optimizations that can only be enabled at system level.")
		];

	}
	else
	{};

}
