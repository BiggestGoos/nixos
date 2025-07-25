{ ... }:
{

	systemd.user.services.luks-resume = {

		Install = {
			WantedBy = [ "post-resume.target" ];
		};

		Unit = {
			Requisite = [ "post-resume.target" ];
		};

		Service = {
			Type = "oneshot";
			ExecStart = "loginctl unlock-session";
		};

	};

}
