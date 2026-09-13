{
  szy,
  lib,
  config,
  pkgs,
  ...
}:
(szy config).objects.make {

  name = "fastfetch";
  namespace = [ "packages" ];

  output.config = {
    programs.fastfetch = {
      enable = true;
    };
  };

}
