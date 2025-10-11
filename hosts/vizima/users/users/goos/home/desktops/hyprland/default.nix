{ szy, desktop, ... }:
{

	imports = [
		(szy.utils.fromShared "users/user/desktops/hyprland")
	];

	"${szy}".desktops.options.applications = {

		terminalEmulator.command = "kitty --single-instance";
		fileManager.command = "yazi";
		fileManagerGui.command = "nemo";

	};

}
