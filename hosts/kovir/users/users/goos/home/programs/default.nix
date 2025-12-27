{ szy, ... }:
{

	imports = [
		(szy.utils.fromShared "users/user/programs/terminalTools")
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
