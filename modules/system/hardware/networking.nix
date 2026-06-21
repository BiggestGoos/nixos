{ szy, lib, config, ... }:
let

	cfg = config."${szy}".networking;

in
{

	options."${szy}".networking = 
	{

		hostName = lib.mkOption 
		{
			type = lib.types.str;
			readOnly = true;
			default = szy.data.host.name;
		};

		interfaceNames = lib.mkOption 
		{
			type = lib.types.attrsOf lib.types.str;
			default = {};
		};

	};

	config = {

		"${szy}".objects.user.data.types.normal.groups = [ "networkmanager" ];

		networking = 
		{

			hostName = cfg.hostName;

			wireless = 
			{
				
				enable = false;

				iwd = 
				{

					enable = true;

					settings = 
					{
				
						General.AddressRandomization = "network";
						Settings.AutoConnect = true;

					};
	
				};

			};

			networkmanager = 
			{
				
				enable = true;

				wifi.backend = "iwd";

			};

		};
		
		systemd.network.links = 
		lib.attrsets.mapAttrs' 
		(name: value: 
		{
			name = "10-${name}";
			value = 
			{
		    	matchConfig.PermanentMACAddress = value;
		    	linkConfig.Name = name;
			};
		}) cfg.interfaceNames;

	};

}
