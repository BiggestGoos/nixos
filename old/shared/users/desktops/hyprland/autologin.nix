{ desktop, pkgs, szy, lib, config, hostname, ... }:
let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  session = "${pkgs.uwsm}/bin/uwsm start -F -- ${pkgs.hyprland}/share/wayland-sessions/hyprland.desktop";
  username = config."${szy}".desktops.components.autologin.user;
in
lib.mkIf (config."${szy}".desktops.components.autologin.enabled)
{
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${session} > /tmp/hyprland.log 2>&1";
        user = "${username}";
      };
      default_session = lib.mkIf (desktop.isDefaultStrict [ "hyprland" ]) {
        command = "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session";
        user = "greeter";
      };
    };
  };
}
