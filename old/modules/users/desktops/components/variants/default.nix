{ szy, config, ... }:
szy.variants.mkVarying
{

	path = ./.;
	inherit config;

	option = [ "desktops" ];

	variants = [
		"autologin"
		"hibernateResume"
		"wayland"
	];

}
