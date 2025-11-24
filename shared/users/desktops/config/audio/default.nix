{ szy, lib, config, ... }:
let

	inherit (config."${szy}".desktops.options.audio) server;

in
{

	imports = [
		./pipewire.nix
	];

}
