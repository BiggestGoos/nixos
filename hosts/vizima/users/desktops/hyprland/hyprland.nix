{ ... }@args: with args; lib.mkIf (builtins.elem "hyprland" config.desktops.enabled)
{

	programs.hyprland = {
		enable = true;
		withUWSM = true;
	};

}
