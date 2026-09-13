{
  szy,
  lib,
  config,
  pkgs,
  ...
}:
(szy config).objects.make {

  inherits = [ "gaming" ];

  name = "gamemode";
  namespace = [ "packages" ];

  output.config = {
    programs.gamemode = {
      enable = true;
    };
    "${szy}".users.types.gaming.groups = [ "gamemode" ];
  };

}
