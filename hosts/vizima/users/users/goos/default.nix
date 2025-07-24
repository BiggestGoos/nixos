{ pkgs, ... }:
{			

	users.users.goos = {
		isNormalUser = true;
    		
		extraGroups = [ 
			# To use sudo
			"wheel"
			# To manage network settings with NetworkManager
			"networkmanager"
			# To manage nix configuration
			"nixmgr"
			# To use gamemode
			"gamemode"
		];

		shell = pkgs.zsh;
	};

}
