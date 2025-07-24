{ ... }:
{

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	nixpkgs.config.allowUnfree = true;

	# Needed to make certain changes with home-manager not require it to download files after every garbage-collection
	nix.settings.keep-outputs = true;
	nix.settings.keep-derivations = true;

}

