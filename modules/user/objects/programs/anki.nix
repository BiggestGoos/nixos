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

  name = "anki";
  namespace = [ "programs" ];

  constant.type = "gui";

  variable.program.package.input = pkgs.anki;

  output.config =
    { constant, ... }:
    {
      home.packages = [ constant.program.package.final ];
    };

}
