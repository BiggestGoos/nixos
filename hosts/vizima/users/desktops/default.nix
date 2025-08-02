{ pkgs, lib, config, desktop, szy, ... }:
{

	options.desktops = {
		default = lib.mkOption {
			type = lib.types.enum szy.desktops.available;
			default = "desktop-hyprland";
		};
		enabled = lib.mkOption {
			type = lib.types.listOf (lib.types.enum szy.desktops.available);
			default = [ "desktop-hyprland" ];
		};
	};

	config = {	

		profiles.base.branches.desktop.branches = {

			hyprland = {

				imports = [
					./hyprland
				];

			};

			gnome = {
				
				imports = [
					./gnome
				];

			};

			plasma = {

				imports = [
					./plasma
				];

			};

		};

		profiles.base.branches.desktop.imports = [ ];
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
		boot.loader.systemd-boot.extraInstallCommands = ''
			${pkgs.gnused}/bin/sed -i -E "s/default nixos-generation-([0-9]+).*\.conf/default nixos-generation-\1-specialisation-${config.desktops.default}.conf/" /boot/loader/loader.conf
		'';

	};

}
