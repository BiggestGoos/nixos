{
  szy,
  lib,
  config,
  pkgs,
  ...
}:
(szy config).objects.make {

  inherits = [
    [
      "programs"
      "fileManager"
    ]
  ];
  #extends = [ "terminalApplication" ];

  name = "yazi";
  namespace = [ "programs" ];

  constant.type = "cli";

  output.config = {

    programs.yazi = {
      enable = true;
    };

  };

}
