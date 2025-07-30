{ pkgs, ... }@args:
let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  session = "${pkgs.uwsm}/bin/uwsm start -F -- ${pkgs.hyprland}/share/wayland-sessions/hyprland.desktop";
  username = "goos";
in
with args; lib.mkIf (config.desktops.default == "hyprland")
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
