{ szy, lib, config, pkgs, ... }:
let
	package = pkgs.floorp-bin;
in
szy.programs.mkInstance
{

	inherit config;
	program = "browser";
	name = "floorp";

	values = 
	{ finalCommand, ... }:
	{
		inherit package;
		desktopEntry = "floorp.desktop";
		search = "${finalCommand} --search";
	};

	configuration = 
	{ enabled, optionKeys, ... }:
	szy.themes.mkThemed
	{

		path = ./.;
		inherit config enabled;

		option = optionKeys;

		themes = [ "default" ];
		defaultTheme = "default";

		configuration = {

			nixpkgs.overlays = [
 				(final: prev: {
				    floorp-bin-unwrapped = prev.floorp-bin-unwrapped.overrideAttrs (old: {
					    src = final.fetchurl {
							url = "https://github.com/Floorp-Projects/Floorp/releases/download/v12.7.0/floorp-linux-x86_64.tar.xz";
							hash = "sha256-feIRCZuyB8xwUoI1FMWJQ6yupgC2aAavADQ9mrk0zMM=";
						};
					});
				})
			];

			programs.floorp = {

				enable = true;

				profiles."${config.home.username}" = {

					id = 0;
					isDefault = true;

				};

			};

		};

	};

}
