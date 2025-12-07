{ szy, lib, config, pkgs, osConfig, ... }:
let
	globalEnabled = osConfig."${szy}".programs.steam.instances.steam.enabled;

	package = pkgs.steam;
in
{

	imports = [
		(szy.programs.mkInstance
		{

			inherit config;
			program = "steam";

			values = 
			{ finalCommand, command, ... }:
			rec {
				inherit package;
				autostart = "${finalCommand} ${silentArgument}";
				shutdown = "${command} -shutdown";
				bigPictureArgument = "-tenfoot";
				silentArgument = "-silent";
				chooseUserArgument = "-userchooser";
			};

			configuration = 
			{ enabled, ... }:
			{
				imports = [
					(import (szy.utils.fromShared "/users/user/misc/gaming/tools") enabled)
				];
			};

		})
	];

	"${szy}".programs.steam.instances.steam.enabled = lib.mkForce globalEnabled;

}
