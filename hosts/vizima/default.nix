{ szy, pkgs, ... }:
{

	imports = [  
		./users
		./system

		./test.nix
		./test1.1.nix
		./test2.nix
	];

	system.stateVersion = "25.05"; 

}

