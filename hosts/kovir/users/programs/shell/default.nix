{ lib, config, szy, ... }:
{

	"${szy}".objects.shell =
	{

		data =
		{
			enable = true;
		};

		definitions =
		{
			zsh.data.enable = true;
		};

	};

	/*imports = [
		(szy.utils.fromShared "users/programs/shell/zsh")
	];*/

}
