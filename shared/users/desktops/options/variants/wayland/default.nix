variant:
{ lib, ... }:
lib.mkIf variant.enabled
{

	environment.sessionVariables.NIXOS_OZONE_WL = "1";

}
