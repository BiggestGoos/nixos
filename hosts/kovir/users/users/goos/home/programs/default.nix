{ szy, ... }:
{

	imports = [
		(szy.utils.fromShared "users/user/programs/terminalTools")
		(szy.utils.fromShared "users/user/programs/shellTheme/starship")
		./editor
		./shell
		./terminal
		./notes
		./steam
		./discord
		./browser
		./fastfetch
		./fileManager
		./git
		./systemMonitor
		./spotify
		./passwordManager
		./nh
		./lutris
	];

}
