{ szy, lib, config, pkgs, ... }:
(szy config).objects.define
{
	template = "terminal";

	name = "ghostty";

	arguments =
	{

		program.bin.default.defaultArgs = [ "--gtk-single-instance=true" ];

		program.arguments =
		{
			runCommand.args = [ "-e" ];
			remainOpen.args = [ "--wait-after-command" ];
			setDirectory.args = [ "--working-directory=" ];
			setAppID.args = [ "--class=" ];
			setTitle.args = [ "--tile=" ];
		};

		desktopEntry.default.base.path = "com.mitchellh.ghostty";
	
	};

	configuration = 
	{

		programs.ghostty = {
			
			enable = true;

		};

	};

}

