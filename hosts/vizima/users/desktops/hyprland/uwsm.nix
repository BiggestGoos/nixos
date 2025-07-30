{ ... }@args: with args; lib.mkIf (builtins.elem "hyprland" config.desktops.enabled)
{

	programs.uwsm = {
		enable = true;
	};

}
