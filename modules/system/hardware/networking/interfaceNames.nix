{ szy, lib, config, ... }:
let
	cfg = config."${szy}".networking;
in
{

	options."${szy}".networking = 
	{

		interfaceNames = lib.mkOption 
		{
			type = lib.types.attrsOf lib.types.str;
			default = {};
		};

	};

	config = {
		
		systemd.network.links = 
		lib.attrsets.mapAttrs' 
		(
			name: value: 
			{
				name = "10-${name}";
				value = 
				{
			    	matchConfig.PermanentMACAddress = value;
			    	linkConfig.Name = name;
				};
			}
		) cfg.interfaceNames;

	};

}
