# Haskell
{ ... }:
{ pkgs, ... }:
{

  extraPackages = with pkgs; [
    zlib
    ncurses
    icu
  ];

  lsp.servers.hls = {
    enable = true;
    packageFallback = true;
  };

}
