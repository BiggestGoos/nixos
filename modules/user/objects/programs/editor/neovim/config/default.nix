{ enabled, constant, ... }@input:
let
  finalPackage = constant.program.package.final;
in
{
  inputs,
  szy,
  lib,
  ...
}:
if inputs ? nixvim then
  {
    imports = [
      inputs.nixvim.homeModules.nixvim
    ];

    programs.nixvim = enabled {
      enable = true;
      package = finalPackage;

      nixpkgs.useGlobalPackages = true;

      imports = szy.lib.imports.propagate.recursive {
        arg = input // {
          inherit szy;
        };
        directory = ./nixvim;
      };
    };
  }
else
  (enabled {

    programs.neovim = {
      enable = true;

      package = finalPackage;

      extraConfig = ''
        hi Normal ctermbg=none guibg=none

        set number

        set tabstop=2
        set shiftwidth=2
      '';
    };

  })
