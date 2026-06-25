{ szy, lib, config, pkgs, ... }:
(szy config).objects.define
{

	template = "package";

	name = "starship";

	configuration = 
	{

		programs.starship = 
		let
			
			shells = config."${szy}".applications.shell or {};

			shellEnabled = shell: (shells."${shell}" or { enabled = false; }).enabled;

		in
		{

			enable = true;

			settings = import ./settings.nix { inherit lib; };

			enableZshIntegration = shellEnabled "zsh";

		};

	};

}

