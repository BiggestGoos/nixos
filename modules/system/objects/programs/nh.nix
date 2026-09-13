{
  szy,
  lib,
  config,
  pkgs,
  ...
}:
(szy config).objects.make {

  inherits = [ "program" ];

  name = "nh";
  namespace = [ "programs" ];

  variable' = {

    clean = {

      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };

      generations = {

        numberToKeep = lib.mkOption {
          type = lib.types.ints.positive;
          default = 5;
        };

        keepSince = lib.mkOption {
          type = lib.types.str;
          default = "3d";
        };

      };

      optimise = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };

      dates = lib.mkOption {
        type = lib.types.str;
        default = "weekly";
      };

    };

  };

  output.config =
    { variable, ... }:
    {

      programs.nh = {

        enable = true;
        flake = szy.data.flake.root;

        clean =
          let
            cfg = variable.clean;
          in
          {

            enable = cfg.enable;
            dates = cfg.dates;

            extraArgs = "--keep ${builtins.toString cfg.generations.numberToKeep} --keep-since ${cfg.generations.keepSince} ${
              if (cfg.optimise) then "--optimise" else ""
            }";

          };
      };

    };

}
