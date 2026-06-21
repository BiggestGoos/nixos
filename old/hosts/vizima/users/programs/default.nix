{ szy, ... }:
{

	imports = [
		./shell
		./editor
		./fileManager
		./steam
		./git
		(szy.utils.fromShared "users/programs/terminalTools")
		(szy.utils.fromShared "users/programs/nh")
		(szy.utils.fromShared "users/misc/printing/home")
	];

}
