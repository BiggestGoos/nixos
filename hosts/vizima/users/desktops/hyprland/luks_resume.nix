{ pkgs, szy, ... }:# szy.desktops.ifEnabled "hyprland"
{
systemd.sleep.extraConfig = ''
  HibernateDelaySec=15min
'';
environment.etc."systemd/system-sleep/post-hibernate-pkill-slock.sh".source =
    pkgs.writeShellScript "post-hibernate-pkill-slock.sh" ''
      if [ "$1-$SYSTEMD_SLEEP_ACTION" = "post-hibernate" ]; then
        ${pkgs.procps}/bin/pkill -USR1 hyprlock
      fi
    '';

}
