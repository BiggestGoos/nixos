{
  szy,
  config,
  inputs,
  pkgs,
  ...
}:
let
  package = inputs.amethyst.outputs.packages.${szy.data.host.system}.default;
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
