{
  szy,
  lib,
  config,
  pkgs,
  ...
}:
let
  szy' = szy config;
  username = "goos";
  final = szy'.objects.utils.get {
    identifier = [
      "users"
      username
    ];
  };
in
{

  "${szy}".objects.users.goos.variable = {
    enable = true;

    modules = szy.lib.imports.recursive ./home;

    settings.hashedPasswordFile = config.sops.secrets."users/goos/password".path;
  };

  imports =
    (szy.lib.imports.recursive ./password)
    ++ (szy.lib.imports.toggled.recursiveWithArgs {
      inherit (final.constant) enabled;
      args = {
        inherit final;
      };
      directory = ./mounts;
    });

}
