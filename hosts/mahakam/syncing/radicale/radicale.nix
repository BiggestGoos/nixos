{
  config,
  ...
}:
let

  unrestricted = config.sync.baseDirectory + "/Unrestricted";
  dataFolder = unrestricted + "/Calendar";

  inherit (config.sync) user;
  inherit (config.users.users."${user}") group;

  port = 5232;

in
{

  systemd.tmpfiles.settings."radicale-directory" =
    let
      own = {
        inherit user group;
        mode = "0770";
      };
      value = {
        "d" = own;
        "z" = own;
      };
    in
    {
      "${dataFolder}" = value;
    };

  networking.firewall.allowedTCPPorts = [ port ];

  services.radicale = {

    enable = true;

    inherit user group;

    settings = {

      server = {
        hosts = [
          "0.0.0.0:${builtins.toString 5232}"
          "[::]:${builtins.toString 5232}"
        ];
      };

      storage.filesystem_folder = dataFolder;

    };

  };

}
