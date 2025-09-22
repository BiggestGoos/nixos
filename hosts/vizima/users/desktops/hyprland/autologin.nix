{ pkgs, szy, lib, config, hostname, ... }:
let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  session = "${pkgs.uwsm}/bin/uwsm start -F -- ${pkgs.hyprland}/share/wayland-sessions/hyprland.desktop";
  username = config."${szy}".users.default;
in
szy.desktops.ifDefault config "hyprland"
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
