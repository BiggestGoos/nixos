{ szy, lib, osConfig, config, pkgs, ... }:
(szy config).objects.define
{

	template = "gameLauncher";

	name = "lutris";

	arguments = 
	let

		steam = szy.objects.utils.definition.get { inherit config; identifier = { name = "steam"; template = "gameLauncher"; }; };

	in
	{

		package = 
		lib.mkDefault
		(
			lib.trivial.warnIf
			(
				steam == {}
			)
			"There is no steam definition, getting steam package directly from system config"
			(steam.data or {}).package or osConfig.programs.steam.package
		);

		application.type = "gui";

	};

	configuration = 
	{ final, ... }:
	{

		programs.lutris = {

			enable = true;

			steamPackage = final.data.package;

			protonPackages = [
				pkgs.proton-ge-bin
			];
			defaultWinePackage = pkgs.proton-ge-bin;

			/*extraPackages = with pkgs; [
				libadwaita
				gtk4
			];*/

		};

	};

}

