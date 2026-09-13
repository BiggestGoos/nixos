{ szy, ... }:
{

  "${szy}".catalog.programs = {
    git.enable = true;
    neovim.enable = true;
    yazi.enable = true;
    zsh.enable = true;

    default = {
      shell.cli = "zsh";
      editor = {
        cli = "neovim";
        any = "neovim";
      };
      fileManager = {
        cli = "yazi";
        any = "yazi";
      };
    };

  };

}
