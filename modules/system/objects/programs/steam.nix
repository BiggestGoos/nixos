{ szy, lib, config, pkgs, ... }:
(szy config).objects.make
{

	inherits = [ "application" "gaming" ];

	name = "steam";
	namespace = [ "programs" ];

	constant.type = "gui";
	variable.program.package.input = pkgs.steam;

	output.config =
	{ constant, ... }:
	{

		programs.steam = 
		{
		
			enable = true;

			package = constant.program.package.final;
			
			remotePlay.openFirewall = true;

			#extest.enable = true;

			extraCompatPackages = [
				pkgs.proton-ge-bin
			];

		};

	};

}

