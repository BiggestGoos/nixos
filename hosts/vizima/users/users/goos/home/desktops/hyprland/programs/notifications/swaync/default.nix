{ ... }@args: with args; lib.mkIf (builtins.elem "hyprland" osConfig.desktops.enabled)
{

	services.swaync = {
		enable = true;
	};

}
