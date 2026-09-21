{ szy, lib, ... }:
{

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = lib.mkIf (szy.data.host.name != "mahakam") {

      "mahakam" = {
        HostName = "mahakam";
        User = "goos";
      };

    };
  };

}
