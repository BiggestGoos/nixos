{ szy, lib, config, pkgs, ... }:
{

	"${szy}".objects.user.definitions.goos.data =
	{
		enable = true;

		arguments =
		{
			paths =
			[
				./home
			];

			settings =
			{
				# Public keys allowed to authorize
				openssh.authorizedKeys.keys =
				[
					config."${szy}".secrets.public.ssh.kovir.goos
				];
			};
		};

		configuration =
		{ final, ... }:
		{
			services.openssh.settings.AllowUsers = [ final.data.username ];
		};

	};

}
