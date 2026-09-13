{ szy, lib, config, pkgs, ... }:
(szy config).objects.make
{

	inherits = [ [ "programs" "shell" ] ];

	name = "zsh";
	namespace = [ "programs" ];

	constant.type = lib.mkForce "cli";

	output.config =
	{
		programs.zsh =
		{
			enable = true;
		};
	};

}
