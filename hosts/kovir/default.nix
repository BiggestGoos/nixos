{ szy, pkgs, ... }:
{

	imports = [  
		./users
		./system
	];

	system.stateVersion = "26.05"; 

}

