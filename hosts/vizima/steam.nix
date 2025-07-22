{ pkgs, ... }:
{
	programs.steam = {
  		enable = true;
  	
		remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  		dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  		localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
	
		gamescopeSession.enable = true;

	};

	programs.gamemode.enable = true;

	users.users.goos.extraGroups = [ "gamemode" ];

	boot.kernel.sysctl."vm.max_map_count" = 2147483642;

}
