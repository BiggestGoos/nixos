{ my, ... }:
{

	imports = [  
		(import (my.utils.fromRoot "/shared/system/management.nix") { path = "/etc/nixos"; })
    		./users
		./system
		./misc
	];
 
	system.stateVersion = "25.05"; 

}

