{ ... }:
{

	nixpkgs.config.allowUnfree = true;

	nix = {

		settings = {

			experimental-features = [ "nix-command" "flakes" ];

			# Needed to make certain changes with home-manager not require it to download files after every garbage-collection
			keep-outputs = true;
			keep-derivations = true;

			auto-optimise-store = true;

			trusted-users = [
				"root"
				"@nixmgr"
			];

		};

	};

}

