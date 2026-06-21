{ lib, config, szy, ... }:
{

	"${szy}".objects.editor =
	{

		data =
		{
			default.any.identifier.name = "neovim";
			default.cli.identifier.name = "neovim";
		};

		definitions =
		{

			neovim.data =
			{
				enable = true;
			};

			helix.data =
			{
					enable = true;
			};

		};

	};

	/*imports = [
		(szy.utils.fromShared "users/user/programs/editor/neovim")
	];*/

}
