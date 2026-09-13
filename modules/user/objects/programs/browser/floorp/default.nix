{
  szy,
  lib,
  config,
  pkgs,
  ...
}:
(szy config).objects.make {

  name = "floorp";
  namespace = [ "programs" ];

  inherits = [
    [
      "programs"
      "browser"
    ]
  ];

  constant.type = "gui";

  variable = {
    program.package.input = pkgs.floorp-bin;
    #program..search.args = [ "--search" ];
  };

  output.config =
    { constant, ... }:
    {
      programs.floorp = {
        enable = true;

        package = constant.program.package.final;

        profiles."${config.home.username}" = {
          id = 0;
          isDefault = true;
        };
      };
    };
}
