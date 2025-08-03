{ osConfig, szy, ... }:
{

#	imports = [
#		./${osConfig.desktops.default}
#	] ++ (builtins.map (name: ./${name}) osConfig.desktops.enabled);

	imports = if (osConfig.desktops.enabled == null) then [] else (builtins.map (name: ./${name}) osConfig.desktops.enabled);

}
