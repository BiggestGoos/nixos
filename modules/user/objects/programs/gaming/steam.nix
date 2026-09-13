{
  szy,
  lib,
  osConfig,
  config,
  pkgs,
  ...
}:
(szy config).objects.make {

  inherits = [
    [
      "programs"
      "gameLauncher"
    ]
  ];

  name = "steam";
  namespace = [ "programs" ];

  constant.type = "gui";

  variable =
    { meta, ... }:
    let

      systemSteam = szy.objects.utils.get {
        config = osConfig;
        inherit (meta) identifier;
      };

    in
    {
      program.package.input = systemSteam.constant.program.package.final;
      enable = lib.mkIf (!systemSteam.constant.enabled) (lib.mkForce false);
    };

  output.config =
    { constant, ... }:
    {

      home.packages = [ constant.program.package.final ];

    };

}
