{
  szy,
  lib,
  config,
  pkgs,
  ...
}:
{

  "${szy}".catalog = {

    programs = {
      nh.enable = true;
      steam.enable = true;
      neovim.enable = true;
      zsh.enable = true;
      yazi.enable = true;

      default = {

        editor.cli = "neovim";
        shell.cli = "zsh";
        fileManager.cli = "yazi";

      };

    };

  };

}
