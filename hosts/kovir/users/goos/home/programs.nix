{ szy, lib, ... }:
{

  "${szy}".catalog.programs = {

    anki.enable = true;
    discord.enable = true;
    floorp.enable = true;
    helix.enable = true;
    ranger.enable = true;
    steam.enable = true;
    kitty.enable = true;

    default = {
      browser.gui = "floorp";
    };

  };

  programs = {
    obsidian.enable = true;
  };

}
