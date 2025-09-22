{ szy, ... }:
{

	networking.hostName = szy.utils.hostname;
	networking.networkmanager.enable = true;
		
  	systemd.network.links."10-lan0" = {
    	matchConfig.PermanentMACAddress = "bc:6e:e2:d4:62:af";
    	linkConfig.Name = "lan0";
 	};

}
