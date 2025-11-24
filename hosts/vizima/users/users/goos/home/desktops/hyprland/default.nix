{ szy, desktop, ... }:
{

	imports = [
		(szy.utils.fromShared "users/user/desktops/desktops/hyprland")
	];

	"${szy}".desktops.options.actions.actions.category.programs.set = {

		terminalEmulator.command = "kitty --single-instance";
		fileManager.command = "yazi";
		fileManagerGui.command = "nemo";

	};

}
