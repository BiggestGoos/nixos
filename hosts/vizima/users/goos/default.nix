{ szy, lib, config, pkgs, ... }:
{

	"${szy}".objects.users.goos.variable =
	{

		enable = true;

		modules = szy.lib.imports.recursive ./home;

		settings.hashedPasswordFile = config.sops.secrets."users/goos/password".path;
	};

	imports = (szy.lib.imports.recursive ./password);

}
