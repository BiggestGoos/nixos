{ szy, lib, config, pkgs, ... }:
let
	username = "goos";
	final = config."${szy}".objects.user.definitions."${username}";
	template = (szy config).objects.utils.template.get { identifier = final.meta.template; };
in
{

	"${szy}".objects.user.definitions.goos.data =
	{

		enable = true;

		modules = szy.lib.imports.recursive ./home;

		settings.hashedPasswordFile = config.sops.secrets."users/goos/password".path;
	};

	imports = (szy.lib.imports.recursive ./password);

}
