{
  inputs,
  szy,
  hostname,
  modules,
}:
let
  inherit (inputs) nixpkgs;
  inherit (nixpkgs) lib;

  sharedArgs = {
    inherit inputs;
  };

  szyModules = inputs.szy.modules;
in
{
  nixosConfigurations.${hostname} = lib.nixosSystem {
    inherit (szy.data.host) system;

    specialArgs = sharedArgs // {
      szy = szy.addArguments {
        configType = "system";
      };
    };

    modules =
      modules
      ++ (szyModules.system)
      ++ (szy.lib.imports.recursive szy.data.root.modules.system)
      ++ (szy.lib.imports.recursive szy.data.host.path)
      ++ [
        inputs.home-manager.nixosModules.home-manager
        (
          {
            config,
            pkgs,
            ...
          }:
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;

              backupFileExtension = "backup";
              overwriteBackup = true;

              users =
                let
                  allUsers =
                    ((szy config).objects.utils.get {
                      identifier = [
                        "template"
                        "user"
                        "homeManaged"
                      ];
                    }).meta.allObjects;
                  users' = builtins.map (
                    identifier:
                    let
                      user = (szy config).objects.utils.get { inherit identifier; };
                    in
                    {
                      name = user.constant.username;
                      value = {
                        imports = user.variable.modules;
                      };
                    }
                  ) allUsers;

                  users = builtins.listToAttrs users';
                in
                users;

              extraSpecialArgs = sharedArgs // {
                szy = szy.addArguments {
                  configType = "user";
                };
              };
              sharedModules = (szyModules.user) ++ (szy.lib.imports.recursive szy.data.root.modules.user);
            };
          }
        )
      ];
  };
}
