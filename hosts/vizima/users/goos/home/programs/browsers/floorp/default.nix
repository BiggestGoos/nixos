{ inputs, hostname, ... }:
{

	programs.floorp = {

		enable = true;

		# Temporary, while regular floorp doesn't seem to work
		package = inputs.floorp-disable-lto.legacyPackages.x86_64-linux.floorp;

		languagePacks = [
			"en-US"
			"sv-SE"
		];

		profiles."${hostname}" = {

			userChrome = builtins.readFile ./css/userChrome.css;
			userContent = builtins.readFile ./css/userContent.css;

		};

	};

}
