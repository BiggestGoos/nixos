{ szy, lib, osConfig, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "gameLauncher";

	name = "steam";

	arguments = 
	{ final, object }:
	let

		systemSteam = szy.objects.helper.getDefinition { config = osConfig; name = "steam"; template = "application"; };

	in
	{

		package = systemSteam.data.package;
		enable = lib.mkIf (!systemSteam.data.enabled) (lib.mkForce false);

		application.type = "gui";

	};

	configuration = 
	{ enabled, final, object }:
	{

		home.packages = [ final.data.package ];

	};

}

