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

				home.activation.setSteamScale = 
				let

					configPath = config.home.homeDirectory + "/.steam/steam/config/config.vdf";

					scale = if (osConfig."${szy}".desktops.enabled != null) then builtins.toString osConfig."${szy}".desktops.components.displays.default.values.scale else "1.0";

				in
				lib.hm.dag.entryAfter ["writeBoundary"] 
				''
    				run ${(pkgs.writers.writePython3 "setSteamScale" { libraries = [ pkgs.python313Packages.vdf ]; }

''
import vdf

path = "${configPath}"

config = vdf.load(open(path))

config['InstallConfigStore']['Accessibility'] = {'DesktopUIScale': ${scale}}

vdf.dump(config, open(path, 'w'), pretty=True)
'')}

				'';

			};

		})
	];

	"${szy}".programs.steam.instances.steam.enabled = lib.mkForce globalEnabled;

}
