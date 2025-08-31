{ pkgs, lib, config, szy, ... }:
{

	imports = [
		(szy.utils.fromRoot "szy/desktops")
	];

	config = {	

		profiles.base.branches = 
		let
		
			mkDesktops = desktops: builtins.listToAttrs (builtins.map (desktop: 
			let
				default = desktop.default;
				enabled = [ default ] ++ (desktop.enabled or [  ]);

				value.configuration = {
					imports = (builtins.map (e: ./${e}) enabled);

					desktops = { inherit default enabled; };
				};
			in
				{
					name = default;
					value = value;
				}
			) desktops);

		in
			mkDesktops [
			{
				default = "hyprland";
#				enabled = [ "gnome" ];
			}
			{
				default = "gnome";
#				enabled = [ "hyprland" ];
			}
			{
				default = "plasma";
#				enabled = [ "hyprland" ];
			}
			];

		/*{

			hyprland = {

				configuration = {
					
					imports = [
						./hyprland
					];

					desktops.default = "hyprland";
					desktops.enabled = [ "hyprland" ];

				};

			};

			gnome = {
				
				configuration = {
					
					imports = [
						./gnome
					];

				};

			};

			plasma = {

				configuration = {
					
					imports = [
						./plasma
					];

				};

			};

		};*/

/*
		specialisation = 
		let
			hyprland = "hyprland";
			gnome = "gnome";
			plasma = "plasma";
	
			mkConfiguration = default: enabled:
			{ 
				configuration = 
				{ 
					config = {
						
						environment.etc."specialisation".text = default;

						desktops = {
							default = default;
							enabled = enabled ++ [ default ];
						};
					};

					imports = [
						./${default}
					] ++ (builtins.map (name: ./${name}) enabled);

				}; 
			};

		in
		{
		
			${hyprland} = mkConfiguration hyprland [ ];
			${gnome} = mkConfiguration gnome [ "hyprland" ];
			${plasma} = mkConfiguration plasma [ ];
	
		};*/

		# Make agnostic to bootloader, or at least throw error if not systemd-boot for the moment.
		#boot.loader.systemd-boot.extraInstallCommands = ''
		#	${pkgs.gnused}/bin/sed -i -E "s/default nixos-generation-([0-9]+).*\.conf/default nixos-generation-\1-specialisation-${config.desktops.default}.conf/" /boot/loader/loader.conf
		#'';

	};

}
