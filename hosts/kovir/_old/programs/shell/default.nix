{ lib, config, szy, ... }:
{

	"${szy}".objects.shell =
	{

		definitions =
		{
			#zsh.data.enable = true;
		};

	};

	/*imports = [
		(szy.utils.fromShared "users/programs/shell/zsh")
	];*/

}
