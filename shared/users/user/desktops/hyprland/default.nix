{ ... }:
{

	imports = [
		./programs
		./themes
		./configuration
		./uwsm.nix
	];

	services.hyprpolkitagent.enable = true;

}
