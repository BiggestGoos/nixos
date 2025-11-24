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

}
