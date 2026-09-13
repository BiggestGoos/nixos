{
  szy,
  lib,
  config,
  pkgs,
  ...
}:
(szy config).objects.make {

  inherits = [ "gaming" ];

  name = "gamescope";
  namespace = [ "packages" ];

  output.config = {
    programs.gamescope = {
      enable = true;
    };
  };

}
