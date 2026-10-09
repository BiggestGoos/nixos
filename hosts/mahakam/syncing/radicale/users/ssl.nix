{ config, ... }:
{

  sops.secrets =
    let
      secretValue =
        let
          inherit (config.services.radicale) user;
        in
        {
          sopsFile = ./users.secret.yaml;
          owner = user;
          inherit (config.users.users."${user}") group;
        };
    in
    {
      "radicale/users" = secretValue;
    };

  services.radicale.settings.auth = {
    type = "htpasswd";
    htpasswd_filename = config.sops.secrets."radicale/users".path;
    htpasswd_encryption = "autodetect";
  };

}
