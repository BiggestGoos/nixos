{ lib, config, szy, ... }:
{

	"${szy}".objects.editor =
	{

		data =
		{
			default.cli.identifier.name = "neovim";
		};

		definitions =
		{

			neovim.data =
			{
				enable = true;
			};

		};

	};

	/*imports = [
		(szy.utils.fromShared "users/programs/editor/neovim")
	];*/

}
