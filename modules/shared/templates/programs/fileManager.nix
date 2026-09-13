{
  szy,
  lib,
  config,
  pkgs,
  ...
}:
(szy config).objects.make.template {

  name = "fileManager";
  namespace = [ "programs" ];

  inherits = [
    "default"
    "application"
  ];

}
