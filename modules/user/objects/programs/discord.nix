{
  szy,
  lib,
  osConfig,
  config,
  pkgs,
  ...
}:
(szy config).objects.make {

  inherits = [ "application" ];

  name = "discord";
  namespace = [ "programs" ];

  constant.type = "gui";

  output.config = {
    programs.discord.enable = true;
  };

}
