{ pkgs, ... }@args: with args; lib.mkIf (builtins.elem "hyprland" osConfig.desktops.enabled)
{

	home.packages = with pkgs; [
		blueman
		pavucontrol
	];

}
