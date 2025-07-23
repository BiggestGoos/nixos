{ pkgs, ... }:
{			

	isNormalUser = true;
    		
	extraGroups = [ "wheel" "networkmanager" "nixmgr" ];

	shell = pkgs.zsh;

}
