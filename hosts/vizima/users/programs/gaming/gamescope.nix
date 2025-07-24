{ ... }:
{

	programs.gamescope = {

		enable = true;

		# Add cap_sys_nice capability to the GameScope binary so that it may renice itself.
		capSysNice = true;

	};

}
