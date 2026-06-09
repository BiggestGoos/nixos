{ szy, lib, config, pkgs, ... }:
szy.objects.define
{

	inherit config;
	template = "terminal";

	name = "ghostty";

	arguments =
	{ final, object }:
	{

		program.bin.default.defaultArgs = [ "--gtk-single-instance=true" ];
		program.arguments.runCommand.args = [ "-e" ];

		desktopEntry.default.base.path = "com.mitchellh.ghostty";
	
	};

	configuration = 
	{ enabled, final, object }:
	{

		programs.ghostty = {
			
			enable = true;

		};

	};

}

