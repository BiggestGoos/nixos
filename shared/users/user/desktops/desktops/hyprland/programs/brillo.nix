{ pkgs, szy, config, ... }:
let

	brillo = "${pkgs.brillo}/bin/brillo";
	inherit (builtins) toString;

in
{
	
	"${szy}".desktops.options.actions.actions.category.brightness = {

		set = 
		let

			base = display: "${brillo} ${if (display != null) then "-s ${display.backlight.name}" else "-e"}";

		in
		{
	
			raise.command = { step, display ? null }: "${base display} -A ${toString step}";
			lower.command = { step, display ? null }: "${base display} -U ${toString step}";
			set.command = { value, display ? null }: "${base display} -S ${toString value}";
			get.command = { display ? null }: "${base display}";
	
		};

	};

}
