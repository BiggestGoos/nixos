{ szy, desktop, ... }:
{

	imports = [
		(szy.utils.fromShared "users/user/desktops/hyprland")
	];

	"${szy}".desktops.components.actions.actions.category.programs.set = {

		terminalEmulator.command = "kitty --single-instance";
		fileManager.command = "yazi";
		fileManagerGui.command = "nemo";

	};

}
