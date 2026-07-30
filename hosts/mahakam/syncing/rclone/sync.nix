{ pkgs, config, lib, ... }:
let

	rclone = lib.getExe pkgs.rclone;

	syncText = "${rclone} bisync ${config.sync.baseDirectory}/Unrestricted ${config.sync.remoteDirectory}/Unrestricted --create-empty-src-dirs --compare size,modtime,checksum --resilient --conflict-resolve newer --conflict-loser delete";

	firstSyncText = "${syncText} --resync";

	firstSync = pkgs.writeShellScriptBin "firstSync"
	''
		${firstSyncText} $@
	'';

	runSync = pkgs.writeShellScriptBin "runSync" 
	''
		${syncText}
	'';

	user = config.sync.user;
	group = config.users.users."${user}".group;

in
{

	environment.systemPackages =
	[
		runSync
		firstSync
	];

	systemd =
	{

		services.rclone-bisync =
		{
			serviceConfig = 
			{	
				Type = "oneshot";
				ExecStart = lib.getExe runSync;

				User = user;
				Group = group;
  			};

			after = 
			[
				"rclone-config.service"
				"network-online.target"
			];

			wants = [ "network-online.target" ];
		};

		timers.rclone-bisync =
		{
			wantedBy = [ "timers.target" ];

			timerConfig =
			{
				OnBootSec = "1min";
				OnUnitInactiveSec = "1min";
				Persistent = true;
			};
		};

	};

}
