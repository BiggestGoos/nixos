{ lib, config, szy, ... }:
{

	"${szy}".objects.editor =
	{

		data =
		{
			enable = true;
			default.cli.name = "neovim";
		};

		definitions =
		{
			neovim.data.enable = true;
		};

	};

	/*imports = [
		(szy.utils.fromShared "users/programs/editor/neovim")
	];*/

}
