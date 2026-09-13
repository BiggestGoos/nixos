{
  szy,
  config,
  inputs,
  ...
}:
let
  package = inputs.amethyst-nixpkgs.amethyst-mod-manager;
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
