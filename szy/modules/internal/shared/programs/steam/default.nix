{ lib, szy, config, ... }@inputs:
let

	homeManaged = builtins.hasAttr "osConfig" inputs;
	osConfig = inputs.osConfig or {};

in
{

	imports = [
		(szy.programs.mkProgram
		{

			inherit config;
			name = "steam";

			singleInstance = true;

			additionalValues = 
			[
				"autostart"
				"shutdown"
				"bigPictureArgument"
				"silentArgument"
				"chooseUserArgument"
			];

		})
	];

	config = lib.mkIf (homeManaged) {

		"${szy}".programs.steam.enabled = lib.mkForce osConfig."${szy}".programs.steam.enabled;

	};

}
