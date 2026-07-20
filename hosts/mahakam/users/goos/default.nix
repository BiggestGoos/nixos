{ szy, lib, config, pkgs, ... }:
{

	"${szy}".objects.user.definitions."${username}".data =
	{
		enable = true;

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

}
