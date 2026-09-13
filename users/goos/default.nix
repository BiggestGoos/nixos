{
  szy,
  lib,
  config,
  pkgs,
  ...
}:
(szy config).users.user.create "goos" true {

  variable = {

    modules = szy.lib.imports.recursive ./home;

  };

}
