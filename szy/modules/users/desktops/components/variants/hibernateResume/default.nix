variant:
{ szy, lib, config, pkgs, ... }:
{

	# Commands to be run after waking up from a hibernation. If the computer is encrypted then you might for example want to kill eventual lockscreens as the encryption password has already authorized the user. Runs both after waking from regular hibernation as well as after hibernation from 'suspend-then-hibernate'.

	options."${szy}".desktops.components.hibernateResume = {

		commands = lib.mkOption {
			type = lib.types.listOf lib.types.str;
			default = [];
		};

	};

	config =
	let
		scriptName = "${szy}-hibernateResume.sh";
	in
	lib.mkIf (variant.enabled && ((builtins.length config."${szy}".desktops.components.hibernateResume.commands) != 0))
	{

		environment.etc."${"systemd/system-sleep/" + scriptName}".source = pkgs.writeShellScript scriptName
		''
      		if [ "$1-$SYSTEMD_SLEEP_ACTION" = "post-hibernate" ]; then
				${lib.strings.concatLines config."${szy}".desktops.components.hibernateResume.commands}
      		fi
    	'';

	};

}
