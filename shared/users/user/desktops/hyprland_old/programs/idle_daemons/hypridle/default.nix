{ szy, ... }: 
{

	services.hypridle = {

		enable = true;

		settings = {

			general = {

				lock_cmd = "pidof hyprlock || hyprlock --immediate-render";

				unlock_cmd = "pkill -USR1 hyprlock";

				before_sleep_cmd = "loginctl lock-session";

				/*after_sleep_cmd = ''
					hyprctl dispatch dpms on
				'';*/

				inhibit_sleep = 3;

			};

			listener = [

				# Lower brightness
				{
					timeout = 150;
					on-timeout = "";
					on-resume = "";
				}
				# Lock screen
				{
					timeout = 200;
					on-timeout = "loginctl lock-session";
				}
				# Turn off screen
				{
					timeout = 230;
					on-timeout = "hyprctl dispatch dpms off";
					on-resume = "hyprctl dispatch dpms on";
				}
				# Suspend-then-hibernate
				{
					timeout = 900;
					on-timeout = "systemctl suspend-then-hibernate";
				}

			];

		};

	};

}
