{ config, ... }:
{

  sops.secrets =
    let
      secretValue =
        let
          inherit (config.services.radicale) user;
        in
        {
          sopsFile = ./ssl.secret.yaml;
          owner = user;
          inherit (config.users.users."${user}") group;
        };
    in
    {
      "radicale/cert.pem" = secretValue;
      "radicale/key.pem" = secretValue;
    };

  services.radicale.settings.server = {
    ssl = true;
    certificate = config.sops.secrets."radicale/cert.pem".path;
    key = config.sops.secrets."radicale/key.pem".path;
  };

}
