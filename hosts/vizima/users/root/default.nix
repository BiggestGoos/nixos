{ szy, lib, config, pkgs, ... }:
{

	users.users.root.hashedPasswordFile = config.sops.secrets."users/root/password".path;

	imports = (szy.lib.imports.recursive ./password);

}
