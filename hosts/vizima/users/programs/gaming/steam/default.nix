{ pkgs, ... }:
{
	programs.steam = {
  		enable = true;
  	
		remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  		dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  		localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
	
		# Maybe check out: 
		# extest.enable = true;

		gamescopeSession.enable = true;

		protontricks.enable = true;

	};

nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        libkrb5
        keyutils
      ];
    };
  };

}
