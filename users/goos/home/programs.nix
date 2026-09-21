{ szy, lib, ... }:
{

  "${szy}".catalog.programs = {
    git.enable = lib.mkDefault true;
    neovim.enable = lib.mkDefault true;
    yazi.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;

    default = {
      shell.cli = lib.mkDefault "zsh";
      editor = {
        cli = lib.mkDefault "neovim";
        any = lib.mkDefault "neovim";
      };
      fileManager = {
        cli = lib.mkDefault "yazi";
        any = lib.mkDefault "yazi";
      };
    };

  };

}
