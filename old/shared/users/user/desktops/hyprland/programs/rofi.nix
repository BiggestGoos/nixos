{ lib, desktop, ... }:
lib.mkIf (desktop.isEnabledStrict [ "hyprland" ])
{

	programs.rofi.enable = true;

}
