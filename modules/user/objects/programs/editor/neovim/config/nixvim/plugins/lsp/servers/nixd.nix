{ szy, ... }:
{

  lsp.servers.nixd = {

    enable = true;

    config.settings.nixd = {

      nixpkgs.expr = ''import (builtins.getFlake ${szy.data.flake.root}).inputs.nixpkgs { }'';

      options = {

        nixos.expr = ''(builtins.getFlake ${szy.data.flake.root}).nixosConfigurations."${szy.data.host.name}".options'';
        home-manager.expr = ''(builtins.getFlake ${szy.data.flake.root}).nixosConfigurations."${szy.data.host.name}".options.home-manager.users.type.getSubOptions []'';

      };

    };

  };

}
