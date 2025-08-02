{ osConfig, ... }:
{

#	imports = [
#		./${osConfig.desktops.default}
#	] ++ (builtins.map (name: ./${name}) osConfig.desktops.enabled);

	imports = [
		./hyprland
	];

}
