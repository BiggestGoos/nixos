{ lib, config, szy, ... }:
{

	"${szy}".objects.fileManager =
	{

		definitions =
		{
			yazi.data.enable = true;
		};

	};

	/*imports = [
		(szy.utils.fromShared "users/programs/fileManager/yazi")
	];*/

}
