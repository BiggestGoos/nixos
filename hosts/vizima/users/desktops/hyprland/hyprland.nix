{ szy, ... }:# szy.desktops.ifEnabled "hyprland"
{

	programs.hyprland = {
		enable = true;
		withUWSM = true;
	};

}
