{ osConfig, ... }:
{

	imports = if (osConfig.desktops.enabled == null) then [] else (builtins.map (name: ./${name}) osConfig.desktops.enabled);

}
