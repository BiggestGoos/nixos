{ ... }:
{

	programs.git = {
		enable = true;
		settings = {
			user = {
				name = "BiggestGoos";
				email = "gustav@fagerlind.net";
			};
			init = {
				defaultBranch = "main";
			};
			safe = {
				directory = "/etc/nixos";
			};
		};
	};

}
