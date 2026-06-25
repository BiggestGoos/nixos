{ szy, lib, osConfig, config, pkgs, ... }:
(szy config).objects.define
{

	template = "gameLauncher";

	name = "steam";

	arguments = 
	let

		systemSteam = szy.objects.utils.definition.get { config = osConfig; identifier = { name = "steam"; template = "application"; }; };

	in
	{

		package = systemSteam.data.package;
		enable = lib.mkIf (!systemSteam.data.enabled) (lib.mkForce false);

		application.type = "gui";

	};

	configuration = 
	{ enabled, final, template }:
	{

		home.packages = [ final.data.package ];

	};

}

