{ pkgs, szy, lib, config, ... }:
let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  session = "${pkgs.uwsm}/bin/uwsm start -F -- ${pkgs.hyprland}/share/wayland-sessions/hyprland.desktop";
  username = "goos";
in
#/*szy.desktops.ifDefault "hyprland" */ lib.mkIf (is_default)
lib.mkIf (config.desktops.default == "hyprland")
{
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${session} > /tmp/hyprland.log 2>&1";
        user = "${username}";
      };
      default_session = {
        command = "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session";
        user = "greeter";
      };
    };
  };
}
