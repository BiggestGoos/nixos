{
  szy,
  config,
  inputs,
  pkgs,
  ...
}:
let
  package = inputs.amethyst.outputs.legacyPackages.${szy.data.host.system}.amethyst-mod-manager;
in
{

  home.packages = [
    package
  ];

}
/*
  (szy config).objects.make {

  }
*/
