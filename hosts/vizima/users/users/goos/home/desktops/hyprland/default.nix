{ szy, desktop, ... }:
{

	imports = [
		(szy.utils.fromShared "users/user/desktops/hyprland")
	];

	"${szy}".desktops.options.applications.applications = {

		terminalEmulator.command = "kitty --single-instance";
		fileManager.command = "yazi";
		fileManagerGui.command = "nemo";

	};

}
