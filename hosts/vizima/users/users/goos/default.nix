{ pkgs, ... }:
{			

	users.users.goos = {
		isNormalUser = true;
    		
		extraGroups = [ "wheel" "networkmanager" "nixmgr" ];

		shell = pkgs.zsh;
	};

}
