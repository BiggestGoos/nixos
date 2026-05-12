{ szy, pkgs, ... }:
{

	imports = [  
		./users
		./system

		./test.nix
		./test2.nix
	];

	system.stateVersion = "25.05"; 

}

