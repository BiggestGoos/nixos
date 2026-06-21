{ lib, desktops, szy, config, pkgs, ... }:
lib.mkIf (desktops.audio.server == "pipewire")
{

	security.rtkit.enable = true;

  	services.pipewire = {
    		enable = true;
    		alsa.enable = true;
    		alsa.support32Bit = true;
    		pulse.enable = true;
       		jack.enable = true;
	};

	"${szy}".desktops.components.actions.actions.category.audio.category =
	let
		wpctl = "${pkgs.wireplumber}/bin/wpctl";
		inherit (builtins) toString;
	in
	{

		output.set = {

			raise.command = { limit, step }: "${wpctl} set-volume -l ${toString limit} @DEFAULT_AUDIO_SINK@ ${toString step}%+";
			lower.command = { step }: "${wpctl} set-volume @DEFAULT_AUDIO_SINK@ ${toString step}%-";
			muteToggle.command = "${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle";

		};

		input.set = {

			muteToggle.command = "${wpctl} set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

		};

	};

}
