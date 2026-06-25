{ lib, desktop, ... }:
lib.mkIf (desktop.isEnabledStrict [ "hyprland" ])
{

	services.swaync.enable = true;

}
