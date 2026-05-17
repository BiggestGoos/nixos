{ szy, pkgs, ... }:
{

	imports = [  
		./users
		./system
	];

	system.stateVersion = "25.05"; 

}

