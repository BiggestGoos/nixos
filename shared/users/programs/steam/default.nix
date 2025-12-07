{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.steam;
in
szy.programs.mkInstance
{

	inherit config;
	program = "steam";

	values = 
	{ finalCommand, command, ... }:
	rec {
		inherit package;
		autostart = "${finalCommand} ${silentArgument}";
		shutdown = "${command} -shutdown";
		bigPictureArgument = "-tenfoot";
		silentArgument = "-silent";
		chooseUserArgument = "-userchooser";
	};

	configuration = 
	{ enabled, optionKeys, ... }:
	{

		options."${szy}" = lib.attrsets.setAttrByPath (optionKeys ++ [ "options" ])
		{

			gamescopeSession.enable = lib.mkOption {
				type = lib.types.bool;
				default = false;
			};

		};

		config.programs.steam = lib.mkIf (enabled) {
	
			enable = true;
  	
			remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  			dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
	  		localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
		
			gamescopeSession.enable = (lib.attrsets.attrByPath optionKeys { gamescopeSession.enable = false; } config).gamescopeSession.enable;

			protontricks.enable = true;
			extest.enable = true;

		};

		imports = [
			((import "${szy.utils.fromShared "/users/misc/gaming/tools"}") enabled)
			(import "${szy.utils.fromShared "/users/misc/gaming/optimizations"}" enabled)
		];

	};

}

