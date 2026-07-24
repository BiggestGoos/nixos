{ config, lib, pkgs, ... }:
let
	user = config.sync.user;
	group = config.users.users."${user}".group;
	home = config.home-manager.users."${user}";
in
{

	programs.fuse.userAllowOther = true;

	home-manager.users."${config.sync.user}" =
	{
		programs.rclone =
		{
	
			enable = true;

			remotes.remote = 
			{

				config =
				{
					type = "onedrive";
					drive_type = "personal";
					drive_id = "AFEAEC28925FF1B6";
				};

				secrets =
				{
					token = config.sops.secrets."rclone/onedrive".path;
				};

				/*mounts."Sync" =
				{
					enable = true;
					mountPoint = config.sync.remoteDirectory;

					options =
					{
						cache-dir = home.xdg.cacheHome;
						vfs-cache-mode = "full";
						vfs-cache-poll-interval = "5s";

						allow-other = true;
					};
				};*/
	
			};

		};

		systemd.user.services =
		{
			rclone-config.Install.WantedBy = lib.mkForce [];
			#"rclone-mount:Sync@remote".Install.WantedBy = lib.mkForce [];
		};

	};

	environment.systemPackages =
	[
		pkgs.rclone
	];

	systemd =
	{
		services =
		{

			rclone-config =
			let
				userService = home.systemd.user.services.rclone-config;
			in
			{
				wantedBy = [ "multi-user.target" ];
				serviceConfig = userService.Service //
				{
					User = user;
					Group = group;
				};
				unitConfig = userService.Unit;
			};

			/*"rclone-mount:Sync@remote" =
			let
				userService = home.systemd.user.services."rclone-mount:Sync@remote";
			in
			{
				wantedBy = [ "multi-user.target" ];
				after = [ "rclone-config.service" ];
				serviceConfig = userService.Service //
				{
					User = user;
					Group = group;
				};
				unitConfig = userService.Unit //
				{
					ConditionPathExists = config.sync.remoteDirectory;
				};
			};*/

		};

		/*tmpfiles.settings."sync-remote" = 
		{
			"${config.sync.remoteDirectory}" =
			let
				value = 
				{
					inherit user group;
					mode = "0770";
				};
			in
			{
				"d" = value;
				"z" = value;
			};
		};*/
	};

}
