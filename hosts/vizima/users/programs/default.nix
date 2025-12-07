{ szy, ... }:
{

	imports = [
		./shell
		./editor
		./fileManager
		./steam
		./git
		(szy.utils.fromShared "users/programs/terminalTools")
	];

}
