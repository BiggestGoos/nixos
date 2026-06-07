{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "terminal";

	name = "ghostty";

	arguments =
	{ final, object }:
	{

		commands.runCommand = command: "${final.data.commands.open} -e ${command}";

		desktopEntry.base.path = "com.mitchellh.ghostty";

	};

	configuration = 
	enabled:
	{ final, object }:
	{

		programs.ghostty = enabled {
			
			enable = true;

		};

	};

}

