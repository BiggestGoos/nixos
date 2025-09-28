{ szy, config, ... }:
szy.variants.mkVarying
{

	path = ./.;
	inherit config;
	option = [ "desktops" "desktops" "hyprland" ];

	variants = [
		"tandi"
	];

}
