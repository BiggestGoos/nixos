{ szy, lib, config, pkgs, ... }:
(szy config).objects.make
{
	inherits = [ [ "programs" "terminal" ] ];

	name = "ghostty";
	namespace = [ "programs" ];

	variable =
	{

		#program.bin.default.defaultArgs = [ "--gtk-single-instance=true" ];
		

		program.actions =
		{
			default.arguments = [ "--gtk-single-instance=true" ];
			runCommand.arguments = [ "--gtk-single-instance=true" "-e" ];
			/*remainOpen.args = [ "--wait-after-command" ];
			setDirectory.args = [ "--working-directory=" ];
			setAppID.args = [ "--class=" ];
			setTitle.args = [ "--tile=" ];*/
		};

		entry.default.base.locator = "com.mitchellh.ghostty";
	
	};

	output.config = 
	{
		programs.ghostty = 
		{	
			enable = true;
		};
	};

}

