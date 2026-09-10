{ szy, lib, config, pkgs, ... }:
(szy config).objects.make
{

	name = "starship";
	namespace = [ "packages" ];

	output.config = 
	{

		programs.starship = 
		let
			
			#shells = config."${szy}".applications.shell or {};

			#shellEnabled = shell: (shells."${shell}" or { enabled = false; }).enabled;

		in
		{

			enable = true;

			settings = import ./settings.nix { inherit lib; };

			#enableZshIntegration = shellEnabled "zsh";

		};

	};

}

