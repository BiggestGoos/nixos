{ lib, szy, config, ... }:
let

	availableServers = [
		"pipewire"
	];

in
{

	options."${szy}".desktops.components.audio = {

		server = lib.mkOption {
			type = lib.types.enum availableServers;
			default = "pipewire";
		};

	};

	imports = [
		./pipewire.nix
		{
			_module.args.desktops.audio.server = config."${szy}".desktops.components.audio.server;
		}
	];

}
