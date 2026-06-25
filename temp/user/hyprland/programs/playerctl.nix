{ pkgs, szy, config, ... }:
let

	playerctl = "${pkgs.playerctl}/bin/playerctl";
	bc = "${pkgs.bc}/bin/bc";

in
{

	services.playerctld.enable = true;

	"${szy}".desktops.components.actions.actions.category.media = {

		set = {

			next.command = "${playerctl} next";
			previous.command = "${playerctl} previous";
			play.command = "${playerctl} play";
			pause.command = "${playerctl} pause";
			playPause.command = "${playerctl} play-pause";
			stop.command = "${playerctl} stop";
	
		};

		category = {

			volume.set = 
			let	
				inherit (builtins) toString;
			in
			{

				raise.command = { step }: "${playerctl} volume $(${bc} -l <<< '${toString step}*0.01')+";
				lower.command = { step }: "${playerctl} volume $(${bc} -l <<< '${toString step}*0.01')-";

			};

		};

	};

}
