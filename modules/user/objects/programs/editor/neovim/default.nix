{ szy, lib, config, pkgs, inputs, ... }:
(szy config).objects.make
{
  name = "neovim";
  namespace = [ "programs" ];

  inherits = [ [ "programs" "editor" ] ];

  constant.type = "cli";

  variable = 
  {
    entry =
    {

      default =
      {
        base.locator = "nvim";
      };

    };

    program.package.input = pkgs.neovim-unwrapped;
  };

  output.imports = [ ./config ];

}

