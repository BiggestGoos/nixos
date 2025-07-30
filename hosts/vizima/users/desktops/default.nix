{ pkgs, lib, config, desktop, ... }:
{
	
	options = { 
		
		desktops = 
		let
			available = [ "hyprland" "gnome" "plasma" ];
		in
		{ 
			
			default = lib.mkOption {
		
				type = lib.types.enum available;
				default = "hyprland";
	
			};

			enabled = lib.mkOption {
				type = lib.types.listOf (lib.types.enum available);
				default = [ "hyprland" ];
			};

		};

	};


	imports = [
		./hyprland
		./gnome
		./plasma
	];

	config = {

		specialisation = 
		let
			hyprland = "hyprland";
			gnome = "gnome";
			plasma = "plasma";

			mkConfiguration = default: enabled: { configuration = 
			{ 
				environment.etc."specialisation".text = default;
				desktops = {
					default = default;
					enabled = enabled ++ [ default ];
				};
			}; };
		in
		{
		
			${hyprland} = mkConfiguration hyprland [ ];
			${gnome} = mkConfiguration gnome [ ];
			${plasma} = mkConfiguration plasma [ ];
	
		};

		# Make agnostic to bootloader, or at least throw error if not systemd-boot for the moment.
		boot.loader.systemd-boot.extraInstallCommands = ''
			${pkgs.gnused}/bin/sed -i -E "s/default nixos-generation-([0-9]+).*\.conf/default nixos-generation-\1-specialisation-${config.desktops.default}.conf/" /boot/loader/loader.conf
		'';

	};

}
