{
  inputs,
  szy,
  lib,
  ...
}:
if inputs ? amethyst-nixpkgs then
  {
    imports = [
      ./amethyst.nix
    ];
  }
else
  { }
