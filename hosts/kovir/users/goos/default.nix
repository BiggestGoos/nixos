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

		paths =
		[
			./home
		];

		settings.hashedPasswordFile = config.sops.secrets."users/goos/password".path;
	};

	imports = 
	(szy.lib.imports.recursive ./password) ++
	(
		szy.lib.imports.toggled.recursiveWithArgs
		{
			inherit (final.data) enabled;
			args =
			{  
				inherit 
					final 
					template
				;
			};
			directory = ./mounts;
		}
	);

}
