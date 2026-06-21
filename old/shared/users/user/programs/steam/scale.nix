enabled:
{ lib, config, osConfig, pkgs, szy, ... }:
enabled
{

	home.activation.setSteamScale = 
	let

		configPath = config.home.homeDirectory + "/.steam/steam/config/config.vdf";

		scale = if (osConfig."${szy}".desktops.desktopData != null && osConfig."${szy}".desktops.desktopData.isDefault [ "hyprland" ]) then builtins.toString osConfig."${szy}".desktops.components.displays.default.values.scale else "1.0";

	in
		lib.hm.dag.entryAfter ["writeBoundary"] 
''
run ${(pkgs.writers.writePython3 "setSteamScale" { libraries = [ pkgs.python313Packages.vdf ]; }

''
import vdf

from os import access, R_OK
from os.path import isfile

path = "${configPath}"


def set_scale(path):
    config = vdf.load(open(path))

    config['InstallConfigStore']['Accessibility'] = \
        {'DesktopUIScale': ${scale}}

    vdf.dump(config, open(path, 'w'), pretty=True)


if isfile(path) and access(path, R_OK):
    set_scale(path)
''
	)}

'';

}
