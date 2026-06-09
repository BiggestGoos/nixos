{ lib, config, szy, ... }:
{

	"${szy}".objects.fileManager =
	{

		data =
		{
			enable = true;
			default.gui.name = "yazi";
			default.cli.name = "yazi";
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
