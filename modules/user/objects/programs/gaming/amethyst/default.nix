{
  inputs,
  szy,
  lib,
  ...
}:
if inputs ? amethyst then
  {
    imports = [
      ./amethyst.nix
    ];
  }
else
  { }
