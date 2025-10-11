sudo /nix/var/nix/profiles/system/specialisation/desktop-hyprland/activate
sudo systemctl daemon-reload; sudo systemctl daemon-reexec
sudo systemctl isolate rescue.target; sudo systemctl isolate default.target
sudo systemctl restart display-manager.service
