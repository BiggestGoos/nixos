{ szy, lib, config, pkgs, ... }:
{

	"${szy}".objects.user.definitions.goos.data =
	{
		enable = true;

		modules = szy.lib.imports.recursive ./home;

		settings =
		{
			# Public keys allowed to authorize
			openssh.authorizedKeys.keys =
			[
				config."${szy}".secrets.public.ssh.kovir.goos
			];

			hashedPasswordFile = config.sops.secrets."users/goos/password".path;
		};
	};

	imports = szy.lib.imports.recursive ./password;

}
