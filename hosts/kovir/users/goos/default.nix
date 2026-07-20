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

	};

	imports = szy.lib.imports.toggled.recursiveWithArgs
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
	};

}
