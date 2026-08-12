{ szy, ... }:
{
	
	"${szy}".objects.user.data.types.normal.groups = [ "networkmanager" ];

	networking =
	{

		hostName = szy.data.host.name;

		networkmanager = 
		{		
			enable = true;

			dns = "systemd-resolved";
			dhcp = "dhcpcd";
		};
	
	};

	services.resolved.enable = true;

}
