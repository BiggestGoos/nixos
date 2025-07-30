{ pkgs, ... }@args: with args; lib.mkIf (builtins.elem "hyprland" config.desktops.enabled)
{

	environment.systemPackages = [
		pkgs.hyprpolkitagent
	];
	
	# Couldn't get it to work
	/*systemd.packages = [
		pkgs.hyprpolkitagent
	];

	systemd.user.services."hyprpolkitagent".enable = true;*/

	system.userActivationScripts = { 
		enable_hyprpolkitagent = "${pkgs.systemd}/bin/systemctl --user enable hyprpolkitagent";
	};

}
