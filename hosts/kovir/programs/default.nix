{ szy, ... }:
{

	imports = [
		./shell
		./editor
		./fileManager
		./steam
	#	./git
	#	(szy.utils.fromShared "users/programs/terminalTools")
	#	(szy.utils.fromShared "users/programs/nh")
	];

	"${szy}".objects.package.definitions.nh.data =
	{
		enable = true;
		clean.enable = true;
	};

}
