{ lib, config, szy, ... }:
{

	"${szy}".objects.fileManager =
	{

		data =
		{
			enable = true;
		};

		definitions =
		{
			yazi.data.enable = true;
		};

	};

	/*imports = [
		(szy.utils.fromShared "users/programs/fileManager/yazi")
	];*/

}
