{ lib, config, szy, ... }:
{

	"${szy}".objects.fileManager =
	{

		data =
		{
			default.gui.identifier.name = "yazi";
			default.cli.identifier.name = "yazi";
		};

		definitions =
		{
			yazi.data.enable = true;
			ranger.data.enable = true;
		};

	};

	/*imports = [
		(szy.utils.fromShared "users/user/programs/fileManager/yazi")
		(szy.utils.fromShared "users/user/programs/fileManager/nemo")
	];*/

}
