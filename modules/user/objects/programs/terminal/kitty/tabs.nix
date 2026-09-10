{ enabled, ... }:
{ szy, config, lib, ... }:
let

	windowMod = "ctrl+shift+";
	tabMod = "ctrl+";
	moveMod = "alt+";

	fileManager = ((szy config).objects.utils.get { identifier = [ "template" "programs" "fileManager" ]; }).constant.default.cli;

	keybindings = {
		"${tabMod}w" = "close_tab";
		"${tabMod}t" = "launch --type=tab";
		"${tabMod}d" = "launch --type=tab --cwd=current --copy-cmdline --copy-env --hold";
		"${tabMod}e" = lib.mkIf (fileManager != null) "launch --type=tab --cwd=current ${fileManager.variable.commands.default}";
		"${tabMod}left" = "previous_tab";
		"${tabMod}right" = "next_tab";
		"${tabMod}tab" = "next_tab";
		"${moveMod + tabMod}left" = "move_tab_backward";
		"${moveMod + tabMod}right" = "move_tab_forward";


	};

in
{

	programs.kitty = enabled {

		inherit keybindings;

	};

}
