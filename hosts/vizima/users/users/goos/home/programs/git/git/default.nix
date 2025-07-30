{ ... }:
{

	programs.git = {
		enable = true;
		userName = "BiggestGoos";
		userEmail = "gustav@fagerlind.net";
		extraConfig = {
			init = {
				defaultBranch = "main";
			};
			safe = {
				directory = "/etc/nixos";
			};
		};
	};

}
