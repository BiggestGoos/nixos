{ szy, lib, config, ... }:
let

	cfg = config."${szy}".networking;

in
{

	imports = [
		./bluetooth.nix
	];

	options."${szy}".networking = {

		hostName = lib.mkOption {
			type = lib.types.str;
			readOnly = true;
			default = szy.utils.hostname;
		};

		interfaceNames = lib.mkOption {
			type = lib.types.attrsOf lib.types.str;
			default = {};
		};

	};

	config = {

		"${szy}".users.types.groups.normal = [ "networkmanager" ];

		networking = {

			hostName = cfg.hostName;

			wireless = {
				
				enable = false;

				iwd = {

					enable = true;

					settings = {
				
						General.AddressRandomization = "network";
						Settings.AutoConnect = true;

					};
	
				};

			};

			networkmanager = {
				
				enable = true;

				wifi.backend = "iwd";

			};

			useDHCP = lib.mkDefault true;

		};
		
		systemd.network.links = lib.attrsets.mapAttrs' (name: value: {
			name = "10-${name}";
			value = {
		    	matchConfig.PermanentMACAddress = value;
		    	linkConfig.Name = name;
			};
		}) cfg.interfaceNames;

	};

}
